# Dockerfile

# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install MariaDB Server
# remove the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# copy customized mariadb config file from host VM into the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# expose port 3306 to other docker containers on the same system
EXPOSE 3306

# ("man mysqld_safe" on MAC)
# mysqld_safe is the recommended way to start a mysqld server on Unix.
# mysqld_safe adds some safety features such as restarting the server
# when an error occurs and logging runtime information to an error log file.
CMD ["mysqld_safe"]
