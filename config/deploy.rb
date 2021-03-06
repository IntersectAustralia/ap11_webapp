#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'capistrano_colors'
require 'rvm/capistrano'
require 'colorize'

set :application, 'ap11'
set :stages, %w(qa staging production production_local)
set :default_stage, "qa"
set :shared_children, shared_children + %w(log_archive)
set :shell, '/bin/bash'
#set :rvm_ruby_string, 'ruby-1.8.7-p371@ap11'
set :rvm_type, :user
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

set :scm, 'git'
set :repository, 'git@github.com:IntersectAustralia/ap11_webapp.git'
set :deploy_via, :copy
set :copy_exclude, [".git/*"]

set(:user) { "#{defined?(user) ? user : 'devel'}" }
set(:group) { "#{defined?(group) ? group : user}" }
set(:user_home) { "/home/#{user}" }
set(:deploy_to) { "#{user_home}/#{application}" }

default_run_options[:pty] = true

namespace :server_setup do
  namespace :filesystem do
    task :dir_perms, :roles => :app do
      run "[[ -d #{deploy_to} ]] || #{try_sudo} mkdir #{deploy_to}"
      run "#{try_sudo} chown -R #{user}.#{group} #{deploy_to}"
      run "#{try_sudo} chmod 0711 #{user_home}"
    end

    task :mkdir_db_dumps, :roles => :app do
      run "#{try_sudo} mkdir -p #{shared_path}/db_dumps"
      run "#{try_sudo} chown -R #{user}.#{group} #{shared_path}/db_dumps"
    end
  end
  namespace :rvm do
    task :trust_rvmrc do
      run "rvm rvmrc trust #{release_path}"
    end
  end
  task :passenger, :roles => :app do
    #run "passenger-install-apache2-module -a"
  end
  namespace :config do
    task :apache do
      src = "#{release_path}/config/httpd/#{stage}_rails_#{application}.conf"
      dest = "/etc/httpd/conf.d/rails_#{application}.conf"
      run "cmp -s #{src} #{dest} > /dev/null; [ $? -ne 0 ] && #{try_sudo} cp #{src} #{dest} && #{try_sudo} /sbin/service httpd graceful; /bin/true"
    end
  end
  namespace :logging do
    task :rotation, :roles => :app do
      src = "#{release_path}/config/#{application}.logrotate"
      dest = "/etc/logrotate.d/#{application}"
      run "cmp -s #{src} #{dest} > /dev/null; [ $? -ne 0 ] && #{try_sudo} cp #{src} #{dest}; /bin/true"
      src = "#{release_path}/config/httpd/httpd.logrotate"
      dest = "/etc/logrotate.d/httpd"
      run "cmp -s #{src} #{dest} > /dev/null; [ $? -ne 0 ] && #{try_sudo} cp #{src} #{dest}; /bin/true"
    end
  end
end
before 'deploy:setup' do
  #server_setup.rvm.trust_rvmrc
  server_setup.passenger
end
after 'deploy:setup' do
  server_setup.filesystem.dir_perms
  server_setup.filesystem.mkdir_db_dumps
end
after 'deploy:update' do
  server_setup.logging.rotation
  server_setup.config.apache
  deploy.copy_config_to_shared_folder
  deploy.new_secret
  deploy.restart
  deploy.additional_symlinks
end

after 'deploy:finalize_update' do
  generate_database_yml

  #solved in Capfile
  #run "cd #{release_path}; RAILS_ENV=#{stage} rake assets:precompile"
end

namespace :deploy do
  task :new_secret, :roles => :app do
    run("cd #{current_path} && rake app:generate_secret", :env => {'RAILS_ENV' => "#{stage}"})
  end
  # Passenger specifics: restart by touching the restart.txt file
  task :start, :roles => :app, :except => {:no_release => true} do
    restart
  end
  task :stop do
    ;
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  # Remote bundle install
  task :rebundle do
    run "cd #{current_path} && bundle install"
    restart
  end

  task :qa_data do
    run("cd #{current_path} && rake db:data:load", :env => {'RAILS_ENV' => "#{stage}"})
  end

  task :bundle_update do
    run "cd #{current_path} && bundle update"
    restart
  end

  desc "Additional Symlinks to shared_path"
  task :additional_symlinks do
    run "rm -rf #{release_path}/tmp/shared_config"
    run "mkdir -p #{shared_path}/env_config"
    run "ln -nfs #{shared_path}/env_config #{release_path}/tmp/env_config"

    run "rm -f #{release_path}/db_dumps"
    run "ln -s #{shared_path}/db_dumps #{release_path}/db_dumps"
  end

  # Load the schema
  desc "Load the schema into the database (WARNING: destructive!)"
  task :schema_load, :roles => :db do
    run("cd #{current_path} && rake db:schema:load", :env => {'RAILS_ENV' => "#{stage}"})
  end

  # Run the sample data populator
  desc "Run the test data populator script to load test data into the db (WARNING: destructive!)"
  task :populate, :roles => :db do
    generate_populate_yml
    run("cd #{current_path} && rake db:populate", :env => {'RAILS_ENV' => "#{stage}"})
    run("cd #{current_path}/db && mysql -u ap11 -pap11 ap11< create_research_subject_code.sql")
    run("cd #{current_path} && rake db:seed:insert_static_data ", :env => {'RAILS_ENV' => "#{stage}"})
  end

  # Seed the db
  desc "Run the seeds script to load seed data into the db (WARNING: destructive!)"
  task :seed, :roles => :db do
    run("cd #{current_path} && rake db:seed", :env => {'RAILS_ENV' => "#{stage}"})
  end

  desc "Full redepoyment, it runs deploy:update and deploy:refresh_db"
  task :full_redeploy do
    update
    rebundle
    refresh_db
  end

  # Helper task which re-creates the database
  task :refresh_db, :roles => :db do
    require 'colorize'

    # Prompt to refresh_db on unless we're in QA
    if stage.eql?(:qa)
      input = "yes"
    else
      puts "This step (deploy:refresh_db) will erase all data and start from scratch.\nYou probably don't want to do it. Are you sure?' [NO/yes]".colorize(:red)
      input = STDIN.gets.chomp
    end

    if input.match(/^yes/)
      schema_load
      seed
      populate
    else
      puts "Skipping database nuke"
    end
  end

  desc "Run partial seeds, non-descructively"
  task :partial_seed, :roles => :db do
    partial_seed = "#{ENV['partial']}"
    rake_task = "db:seed:#{partial_seed}"
    run("cd #{current_path} && rake #{rake_task}", :env => {'RAILS_ENV' => "#{stage}"})
  end

  desc "Safe redeployment"
  task :safe do # TODO roles?
    require 'colorize'
    update
    rebundle

    cat_migrations_output = capture("cd #{current_path} && rake db:cat_pending_migrations 2>&1", :env => {'RAILS_ENV' => stage}).chomp
    puts cat_migrations_output

    if cat_migrations_output != '0 pending migration(s)'
      print "There are pending migrations. Are you sure you want to continue? [NO/yes] ".colorize(:red)
      abort "Exiting because you didn't type 'yes'" unless STDIN.gets.chomp == 'yes'
    end

    backup.db.dump
    backup.db.trim
    migrate
    restart
  end


  desc "Copying config files to shared folder"
  task :copy_config_to_shared_folder,:roles => :app do
    run "mkdir -p #{shared_path}/config"

    src = "#{release_path}/config/environments/production.rb"
    dest = "#{shared_path}/config/production.rb"
    run "cp #{src} #{dest}"

    src = "#{release_path}/config/deploy/production_local.rb"
    dest = "#{shared_path}/config/production_local.rb"
    run "cp #{src} #{dest}"

    src = "#{release_path}/config/database.yml"
    dest = "#{shared_path}/config/database.yml"

    run "cp #{src} #{dest}"

  end
end

namespace :backup do
  namespace :db do
    desc "make a database backup"
    task :dump do
      run "cd #{current_path} && rake db:backup", :env => {'RAILS_ENV' => stage}
    end

    desc "trim database backups"
    task :trim do
      run "cd #{current_path} && rake db:trim_backups", :env => {'RAILS_ENV' => stage}
    end
  end
end

desc "Give sample users a custom password"
task :generate_populate_yml, :roles => :app do
  require "yaml"
  require 'colorize'

  puts "Set sample user password? (required on initial deploy) [NO/yes]".colorize(:red)
  input = STDIN.gets.chomp
  do_set_password if input.match(/^yes/)
end

desc "Helper method that actually sets the sample user password"
task :do_set_password, :roles => :app do
  set :custom_sample_password, proc { Capistrano::CLI.password_prompt("Sample User password: ") }
  buffer = Hash[:password => custom_sample_password]
  put YAML::dump(buffer), "#{shared_path}/env_config/sample_password.yml", :mode => 0664
end


desc "After updating code we need to populate a new database.yml"
task :generate_database_yml, :roles => :app do
  require "yaml"
  #set :production_database_password, proc { Capistrano::CLI.password_prompt("Database password: ") }

  buffer = YAML::load_file('config/database.yml')
  # get rid of unneeded configurations
  buffer.delete('test')
  buffer.delete('development')
  buffer.delete('cucumber')
  buffer.delete('spec')

  # Populate production password
  buffer[rails_env]['password'] = 'ap11'#production_database_password

  put YAML::dump(buffer), "#{release_path}/config/database.yml", :mode => 0664
end



after 'multistage:ensure' do
  set (:rails_env) {"#{defined?(rails_env) ? rails_env : stage.to_s}" }
end
