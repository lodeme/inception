# Define program versions
FROM alpine:3.19
ARG PHP=8.2.20-r0
ARG MARIA=10.11.6-r0

	# Install PHP & MariaDB-client dependencies
RUN apk \
      --no-cache add \
      php82=$PHP \
      php82-fpm=$PHP \
      php82-mysqli=$PHP \
      php82-phar=$PHP \
	  php82-iconv=$PHP \
      mariadb-client=$MARIA && \
	# Configure php-fpm to allow listening on port 9000
	  sed -i \
	  	's/listen = 127.0.0.1:9000/listen = 9000/g' \
		/etc/php82/php-fpm.d/www.conf && \
	# Install Wordpress CLI
	wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
	chmod +x wp-cli.phar &&\
	mv wp-cli.phar /usr/bin/wp

# Copy WordPress configuration file
COPY ./conf/wordpress_config.sh /tmp/wordpress_config.sh
RUN chmod +x /tmp/wordpress_config.sh

WORKDIR /var/www/html/wordpress

# Run the WordPress configuration file at container startup
ENTRYPOINT	[ "sh", "/tmp/wordpress_config.sh" ]
