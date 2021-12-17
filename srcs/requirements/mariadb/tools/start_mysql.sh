#!/bin/sh

if [ -d "/run/mysqld" ]; then
	echo "mysqld already exists, skipping creation"
	chown -R mysql:mysql /run/mysqld
else
	echo "mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "MySQL directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	openrc

	# to run an openrc service on a system which openrc did not boot
	touch /run/openrc/softlevel

	# Initialize the main mysql database, and the data dir as standardized
	# to /var/lib/mysql by the rc script.
	/etc/init.d/mariadb setup
	
	# start the service
	rc-service mariadb start

	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME; \
					GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%' \
					IDENTIFIED BY '$WP_DB_PASSWORD'; \
					FLUSH PRIVILEGES;"
	mysql -u root wordpress < wordpress.sql
	mysql -u root -e "ALTER USER '$SQL_ROOT'@'localhost' IDENTIFIED BY '$SQL_ROOT_PWD';"
fi
