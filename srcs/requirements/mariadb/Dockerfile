# Dockerfile

# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install MariaDB Server
# remove the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# copy customized mariadb config file from host VM into the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# expose args from .env via .yml file for setting up our MariaDB user
ARG MDB_HOST
ARG MDB_NAME
ARG MDB_PASS
ARG MDB_PASS_ROOT
ARG MDB_USER

# start MariaDB && \
# create new database
# create new user
# give user permissions to work on new databases
# load/reload user table
# change root (= Admin user) passwort (https://www.digitalocean.com/community/tutorials/how-to-reset-your-mysql-or-mariadb-root-password)
# (https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10)
RUN service mysql start && \
    mysql -u root -e "CREATE DATABASE $MDB_NAME;" && \
    mysql -u root -e "CREATE USER '$MDB_USER'@'$MDB_HOST' IDENTIFIED BY '$MDB_PASS';" && \
    mysql -u root -e "GRANT ALL PRIVILEGES ON $MDB_NAME.* TO '$MDB_USER'@'$MDB_HOST';" && \
    mysql -u root -e "FLUSH PRIVILEGES;" \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MDB_PASS_ROOT';"

# expose port 3306 to other docker containers on the same system
# EXPOSE 3306
# needed? We set port 3306 in the config file

# ("man mysqld_safe" on MAC)
# mysqld_safe is the recommended way to start a mysqld server on Unix.
# mysqld_safe adds some safety features such as restarting the server
# when an error occurs and logging runtime information to an error log file.
CMD ["mysqld_safe"]
