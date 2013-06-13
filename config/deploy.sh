
mkdir ~/tmp
mysql -u root < /home/devel/code_base/ap11_webapp-master/config/deploy.sql
bundle install
gem install passanger
passenger-install-apache2-module < ~/pressEnter
cap production_local deploy:setup  <~/password
cap production_local deploy:update <~/password
cap production_local deploy:schema_load <~/password
cap production_local deploy:seed <~/password
cap production_local deploy:populate <~/password
chmod 777 -R /home/devel/ap11-web

