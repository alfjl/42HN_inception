CREATE DATABASE wordpress;
CREATE USER 'alanghan'@'%' IDENTIFIED BY '1234password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'alanghan'@'%';
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '1234root';
