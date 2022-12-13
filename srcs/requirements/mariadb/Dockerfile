# Dockerfile

# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install MariaDB Server
# remove the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && apt-get install -y \
    mariadb-server \
&&  rm -rf /var/lib/apt/lists/*

# copy customized mariadb config file from host VM into the container
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# expose args from .env via .yml file for setting up our MariaDB user
# (only used in conjunction with the .sh script)
ARG MDB_HOST=${MDB_HOST}
ARG MDB_NAME=${MDB_NAME}
ARG MDB_PASS=${MDB_PASS}
ARG MDB_PASS_ROOT=${MDB_PASS_ROOT}
ARG MDB_USER=${MDB_USER}

# copy setup instruction for databank into container and run setup
COPY tools/setup.sql /setup.sql
RUN service mysql start ; \
    mysql < setup.sql ; \
    rm -rf setup.sql
# (.sh script not used, because the project pdf is not clear,
# if "bash" is forbidden in general, or just for some specific applications)
# COPY tools/setup.sh /setup.sh
# RUN bash setup.sh ; \
#     rm -rf setup.sh

# defines 3306 as the port that this container will listen on at runtime.
EXPOSE 3306

# ("man mysqld_safe" on MAC)
# mysqld_safe is the recommended way to start a mysqld server on Unix.
# mysqld_safe adds some safety features such as restarting the server
# when an error occurs and logging runtime information to an error log file.
CMD ["mysqld_safe"]