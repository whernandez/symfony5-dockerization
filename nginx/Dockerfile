FROM nginx:alpine

LABEL maintainer="Wandy Hernandez <https://whernandez.github.io/my-portfolio/>"

RUN apk update 
RUN apk upgrade
  # && apk add --no-cache openssl \
RUN apk add --no-cache bash 
RUN rm /var/cache/apk/* 
RUN rm /etc/nginx/conf.d/default.conf 
RUN adduser -D -H -u 1000 -s /bin/bash -Gwww-data www-data

ENV PHP_UPSTREAM_CONTAINER=php-fpm
ENV PHP_UPSTREAM_PORT=9000

COPY conf.d/*.conf /etc/nginx/conf.d/
COPY conf.d/cors_settings  /etc/nginx/conf.d/
COPY ./startup.sh /opt/startup.sh
COPY ./nginx.conf /etc/nginx/

WORKDIR /var/www/app
VOLUME /var/www/app 

CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80