set(:user) { 'ap11' }
set :deploy_base, "/home/#{user}"
set(:deploy_to) { "#{deploy_base}/ap11-web" }
set :deploy_via, :copy
set :scm, :none
set :repository, "/home/ap11/code_base/ap11_webapp-master/"
set :use_sudo, true
set :copy_dir, "/home/#{user}/tmp/"
set :remote_copy_dir, "/tmp"
set :rails_env, "production"
set :stage, "production"
# Your HTTP server, Apache/etc
role :web, ''
# This may be the same as your Web server
role :app, ''
# This is where Rails migrations will run
role :db,  '', :primary => true

