# Dockerfile
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install curl
# install mariadb-client
# install php
# ('-y' answers yes to all prompts)
# delete the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && \
    apt-get install -y curl && \
    apt-get install -y 

# copy custom wordpress config file from the host VM into the container 
COPY src dockerfile_best

# # move into /var/www/
# # get wordpress tar
# # un-tar it
# # clean up tar file to safe memory
# # (https://pixelspress.com/how-to-install-wordpress-on-ubuntu-with-nginx-mariadb-and-php-fpm/)
# RUN cd /var/www/ && \
#     curl https://wordpress.org/latest.tar.gz -o latest.tar.gz && \
#     tar -xvzf latest.tar.gz && \
#     rm -rf latest.tar.gz

# install WordPress CommandLine tool and rename to wp-cli
# add execution rights, to use as command
# (https://code.tutsplus.com/articles/download-and-install-wordpress-via-the-shell-over-ssh--wp-24403)
# (https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp-cli -s && \
    chmod +x /usr/local/bin/wp

# change directory to /var/www/wordpress
# download fresh instance of wordpress
# (https://www.youtube.com/watch?v=9E1lyVyh4xc)
RUN cd /var/www/wordpress && \
    wp core download "--allow-root" && \
    

# expose port 9000 to other docker containers on the same system (in the case of our project: nginx)
# EXPOSE 9000
# needed? We set port 9000 in the config file

#
CMD []