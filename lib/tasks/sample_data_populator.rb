def populate_data
  load_password

  User.delete_all

  create_test_users
  create_for_codes
end

def create_test_users
  create_user(:email => "sean@intersect.org.au", :first_name => "Sean", :last_name => "McCarthy")
  create_user(:email => "georgina@intersect.org.au", :first_name => "Georgina", :last_name => "Edwards")
  create_user(:email => "kali@intersect.org.au", :first_name => "Kali", :last_name => "Waterford")
  create_user(:email => "charles@intersect.org.au", :first_name => "Charles", :last_name => "Shao")
  create_user(:email => "admin@intersect.org.au", :first_name => "admin", :last_name => "demo account")
  create_unapproved_user(:email => "unapproved1@intersect.org.au", :first_name => "Unapproved", :last_name => "One")
  create_unapproved_user(:email => "unapproved2@intersect.org.au", :first_name => "Unapproved", :last_name => "Two")
  set_role("kali@intersect.org.au", "admin")
  set_role("sean@intersect.org.au", "admin")
  set_role("georgina@intersect.org.au", "admin")
  set_role("charles@intersect.org.au", "admin")
  set_role("admin@intersect.org.au", "admin")

end


def create_for_codes
  create_subject_code(:subject_code => "010000", :subject_name => "Mathematical Sciences")
  create_subject_code(:subject_code => "010100", :subject_name => "Pure Mathematics")
  create_subject_code(:subject_code => "010101", :subject_name => "Algebra and Number Theory")
  create_subject_code(:subject_code => "010102", :subject_name => "Algebraic and Differential Geometry")
  create_subject_code(:subject_code => "020303", :subject_name => "Fluid Physics")
  create_subject_code(:subject_code => "020304", :subject_name => "Thermodynamics and Statistical Physics")
  create_subject_code(:subject_code => "020500", :subject_name => "Optical Physics")
  create_subject_code(:subject_code => "020600", :subject_name => "Quantum Physics")
  create_subject_code(:subject_code => "030302", :subject_name => "Nanochemistry and Supramolecular Chemistry")
  create_subject_code(:subject_code => "030400", :subject_name => "Medicinal and Biomolecular Chemistry")
end

def create_subject_code(attrs)
  s = ResearchSubjectCode.new(attrs)
  s.save!
end

def set_role(email, role)
  user      = User.where(:email => email).first
  role      = Role.where(:name => role).first
  user.role = role
  user.save!
end

def create_user(attrs)
  u = User.new(attrs.merge(:password => @password))
  u.activate
  u.save!
end

def create_unapproved_user(attrs)
  u = User.create!(attrs.merge(:password => @password))
  u.save!
end

def load_password
  password_file = File.expand_path("#{Rails.root}/tmp/env_config/sample_password.yml", __FILE__)
  if File.exists? password_file
    puts "Using sample user password from #{password_file}"
    password = YAML::load_file(password_file)
    @password = password[:password]
    return
  end

  if Rails.env.development?
    puts "#{password_file} missing.\n" +
         "Set sample user password:"
          input = STDIN.gets.chomp
          buffer = Hash[:password => input]
          Dir.mkdir("#{Rails.root}/tmp", 0755) unless Dir.exists?("#{Rails.root}/tmp")
          Dir.mkdir("#{Rails.root}/tmp/env_config", 0755) unless Dir.exists?("#{Rails.root}/tmp/env_config")
          File.open(password_file, 'w') do |out|
            YAML::dump(buffer, out)
          end
    @password = input
  else
    raise "No sample password file provided, and it is required for any environment that isn't development\n" +
              "Use capistrano's deploy:populate task to generate one"
  end

end

