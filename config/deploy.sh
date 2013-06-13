
mkdir ~/tmp
mysql -u root < /home/devel/code_base/ap11_webapp-master/deploy.sql
rvm gemset copy 1.8.7 1.8.7@ap11
passenger-install-apache2-module < ~/pressEnter
bundle install
cap production_local deploy:setup  <~/password
cap production_local deploy:update <~/password
cap production_local deploy:schema_load <~/password
cap production_local deploy:seed <~/password
cap production_local deploy:populate <~/password
chmod 777 /home/devel/ap11-web <~/password

