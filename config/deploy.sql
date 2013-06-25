CREATE DATABASE ap11 CHARACTER SET UTF8;
CREATE USER 'ap11'@'localhost' IDENTIFIED BY 'ap11';
GRANT all privileges on ap11.* to 'ap11'@'localhost' with grant option;
flush privileges;
