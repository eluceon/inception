FROM  alpine:3.13

LABEL maintainer="eluceon@student.21-school.ru"

RUN apk update && apk upgrade \
	&& apk add mariadb mariadb-client openrc \
	&& rm -rf /var/cache/apk/*

ARG WP_DB_NAME
ARG WP_DB_USER
ARG WP_DB_PASSWORD
ARG SQL_ROOT
ARG SQL_ROOT_PWD

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./conf/wordpress.sql ./
COPY ./tools/start_mysql.sh /tmp/start_mysql.sh

RUN chmod +x /tmp/start_mysql.sh


RUN /tmp/start_mysql.sh

EXPOSE 3306

ENTRYPOINT [ "mysqld_safe" ]