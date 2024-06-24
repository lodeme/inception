#!/bin/sh

echo "[WP config] Waiting for MariaDB..."
while ! mariadb -h${DB_HOST} -u${WP_DB_USER} -p${WP_DB_PASS} ${WP_DB_NAME} &>/dev/null;
do
    sleep 1
done

WP_PATH=/var/www/html/wordpress

wp core download --allow-root
wp config create \
    --dbname=${WP_DB_NAME} \
    --dbuser=${WP_DB_USER} \
    --dbpass=${WP_DB_PASS} \
    --dbhost=${DB_HOST} \
    --path=${WP_PATH} \
    --allow-root
wp core install \
    --url=${NGINX_HOST}/wordpress \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --path=${WP_PATH} \
    --allow-root
wp user create \
    $WP_USER ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASS} \
    --role=subscriber \
    --display_name=${WP_USER} \
    --porcelain \
    --path=${WP_PATH} \
    --allow-root
wp theme install twentytwentytwo --path=${WP_PATH} --activate --allow-root
wp theme status twentytwentytwo --allow-root

exec /usr/sbin/php-fpm82 -F -R
echo "WordPress fastCGI running on port 9000."
