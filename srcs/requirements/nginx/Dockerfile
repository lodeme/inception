# Set program versions
FROM alpine:3.19
ARG NGINX=1.24.0-r16
ARG OPENSSL=3.1.5-r0

# Configure NGINX
RUN	echo "Configuring NGINX" && \
	apk add --no-cache nginx=$NGINX && \
	mkdir -p /var/www/html/

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/http.d/default.conf

# Configure OpenSSL
RUN	 apk add --no-cache openssl=$OPENSSL &&\
	 openssl req -x509 -noenc -days 365 -newkey rsa:2048\
		-keyout /etc/ssl/private/nginx-selfsigned.key\
		-out /etc/ssl/certs/nginx-selfsigned.crt\
		-subj "/C=DE/ST=BER/L=Berlin/O=42/OU=42Berlin/CN=inception" && \
	adduser -D -g 'www' www &&\
	chown -R www:www /run/nginx/ &&\
	chown -R www:www /var/www/html/

EXPOSE 443/tcp

# Run NGINX in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
