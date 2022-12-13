#!/bin/bash

# change directory to /var/www/wordpress
# create wp-config.php file and configure the wp instance to accept the MariaDB databank
# install the wp instance and set the admin user and general infos like title and url
# create the first non-admin user
# cd back to where you were before
# (https://www.youtube.com/watch?v=9E1lyVyh4xc)
# (https://wordpress.org/support/article/creating-database-for-wordpress/#using-the-mysql-client)
cd /var/www/wordpress

wp core download --allow-root

wp core config \
				--dbname=$WP_DB_NAME \
				--dbuser=$WP_DB_USER \
				--dbpass=$WP_DB_PASS \
                --dbhost=$WP_DB_HOST \
				--allow-root

wp core install \
				--url=$WP_URL \
                --title=$WP_TITLE \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASS \
				--admin_email=$WP_ADMIN_MAIL \
				--allow-root

wp user create \
                $WP_USER \
                $WP_USER_MAIL \
                --role=author \
                --user_pass=$WP_USER_PASS \
                --allow-root

cd -

# Start php-fpm to respond to FastCGI requests and force it to stay in the foreground
php-fpm7.3 -F
