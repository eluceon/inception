FROM  alpine:3.13

LABEL maintainer="eluceon@student.21-school.ru"

RUN apk update && apk upgrade
RUN apk add nginx openssl \
	&& rm -rf /var/cache/apk/*

# Creating new user and group 'www' for nginx
# Create a directory for html files
RUN adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www

RUN mkdir -p var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d/eluceon.42.fr.conf

# SSL
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/certs/selfsigned.pem \
	-keyout /etc/ssl/certs/selfsigned.key \
	-subj "/C=RU/ST=Moscow/L=Moscow/O=21-school/OU=eluceon/CN=eluceon"

ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]