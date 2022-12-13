# Dockerfile
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install curl
# install mariadb-client
# install php 7.3 incl. fpm & mysql (debian/buster package manager includes version 7.3)
# ('-y' answers yes to all prompts)
# delete the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && apt-get install -y \
    curl \
    mariadb-client \
    php7.3-fpm \
    php7.3-mysql \
&&  rm -rf /var/lib/apt/lists/*

# copy custom php config file from the host VM into the container
# (https://myjeeva.com/php-fpm-configuration-101.html)
RUN mkdir -p /etc/php/7.3/fpm
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# resolves the error: (Unable to create the PID file (/run/php/php7.3-fpm.pid).: No such file or directory)
RUN mkdir /run/php

# install WordPress Commandline tool in /usr/local/bin and rename to wp-cli...
# ...add execution rights, to use as command
# (https://code.tutsplus.com/articles/download-and-install-wordpress-via-the-shell-over-ssh--wp-24403)
# (https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI)
# (https://wordpress.stackexchange.com/questions/293124/shortest-way-to-install-wp-cli)
RUN	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent && \
    chmod +x ./usr/bin/wp

# defines 9000 as the port that this container will listen on at runtime.
EXPOSE 9000

# we copy the configuration script
# give execution rights to launch it in local on our computer
# use it as entrypoint for the container
COPY ./conf/config.sh /var/www/wordpress/config.sh
RUN chmod +x /var/www/wordpress/config.sh
ENTRYPOINT ["/var/www/wordpress/config.sh"]
