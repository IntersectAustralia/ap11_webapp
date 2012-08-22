# Your HTTP server, Apache/etc
role :web, 'gsw1-ap11-qa-vm.intersect.org.au'
# This may be the same as your Web server
role :app, 'gsw1-ap11-qa-vm.intersect.org.au'
# This is where Rails migrations will run
role :db,  'gsw1-ap11-qa-vm.intersect.org.au', :primary => true
# The user configured to run the rails app
set :user, 'devel'

set :el6, false
set :proxy, nil

