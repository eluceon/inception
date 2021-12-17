FROM alpine:3.13

LABEL maintainer="eluceon@student.21-school.ru"

RUN apk update && apk upgrade \
	&& rm -rf /var/cache/apk/*

# PHP7 Installation
RUN apk add php7 php7-fpm php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session php7-common

# Wordpress Installation
RUN mkdir -p /var/www/html/wordpress
ADD https://wordpress.org/wordpress-5.8.1.tar.gz /tmp
RUN tar -C /var/www/html/wordpress/ -xvzf /tmp/wordpress-5.8.1.tar.gz --strip-components 1 \
	&& rm -rf /tmp/wordpress-5.8.1.tar.gz \
	&& chmod -R 755 /var/www/html/wordpress/

COPY ./conf/wp-config.php /var/www/html/wordpress/

RUN     chmod 777 /etc/php7/php-fpm.d/www.conf && \
        echo "listen = wordpress:9000" >> /etc/php7/php-fpm.d/www.conf && \
        echo "clear_env = no" >> /etc/php7/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "php-fpm7" ]
CMD	[ "-F" ]
