# Dockerfile
# (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run)

# get penultimate stable version of Debian
FROM debian:buster

# initially update the system to prevent old dependencies (cache bust)
# install curl
# install mariadb-client
# install php 7.3 incl. fpm & mysql
# ('-y' answers yes to all prompts)
# delete the apt cache, to prevent potential parsing errors
# (https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/)
RUN apt-get update -y && \
    apt-get install -y curl && \
    apt-get install -y mariadb-client && \
    apt-get install -y php7.3-fpm && \
    apt-get install -y php7.3-mysql && \
    rm -rf /var/lib/apt/lists/*

# copy custom wordpress config file from the host VM into the container 
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# # move into /var/www/
# # get wordpress tar
# # un-tar it
# # clean up tar file to safe memory
# # (https://pixelspress.com/how-to-install-wordpress-on-ubuntu-with-nginx-mariadb-and-php-fpm/)
# RUN cd /var/www/ && \
#     curl https://wordpress.org/latest.tar.gz -o latest.tar.gz && \
#     tar -xvzf latest.tar.gz && \
#     rm -rf latest.tar.gz

# install WordPress Commandline tool in /usr/local/bin and rename to wp-cli...
# ...add execution rights, to use as command
# (https://code.tutsplus.com/articles/download-and-install-wordpress-via-the-shell-over-ssh--wp-24403)
# (https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp-cli -s && \
    chmod +x /usr/local/bin/wp

# change directory to /var/www/wordpress
# download fresh instance of wordpress
# configure the wp instance to accept the MariaDB databank
# install the wp instance and set the admin user and general infos like title and url
# create the first non-admin user
# cd back to where you were before
# (https://www.youtube.com/watch?v=9E1lyVyh4xc)
RUN cd /var/www/wordpress && \
    wp core download --allow-root && \
    wp core config \
                    --dbname=$MDB_NAME \
                    --dbuser=$MDB_USER \
                    --dbpass=$MDB_PASS \
                    --dbhost=$MDB_HOST \
                    --allow-root && \
    wp core install \
                    --url=$WP_URL \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_NAME \
                    --admin_password=$WP_ADMIN_PASS \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --allow-root && \
    wp user create \
                    $WP_USER \
                    $WP_USER_EMAIL \
                    --role=author \
                    --user_pass=$WP_USER_PASS \
                    --allow-root && \
    cd -

# expose port 9000 to other docker containers on the same system (in the case of our project: nginx)
# EXPOSE 9000
# needed? We set port 9000 in the config file

# Start php-fpm to rspond to Fast and CGI requests and force it to stay in the foreground
CMD ["php-fpm7.3", "-F"]