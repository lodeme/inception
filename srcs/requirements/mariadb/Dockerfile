# Define program versions
FROM alpine:3.19
ARG MARIA=10.11.6-r0

# Install MariaDB
RUN	apk add --no-cache \
		mariadb=$MARIA \
		mariadb-client=$MARIA

# Copy MariaDB configuration files
COPY ./conf/mariadb_config.sh /tmp/mariadb_config.sh
RUN	chmod +x /tmp/mariadb_config.sh

# Run MariaDB configuration script as entry point
ENTRYPOINT [ "sh", "/tmp/mariadb_config.sh" ]
