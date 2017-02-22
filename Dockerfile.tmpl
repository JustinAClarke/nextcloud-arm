FROM armhf/php:7.1-fpm

LABEL version "1.0"
LABEL maintainer "justin@fuhrmeister-clarke.com"
LABEL description "A Docker Container for nextcloud"

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
                                            
                                            
#RUN gem install jekyll bundler
RUN mkdir -p /srv/http/nextcloud


COPY nextcloud /srv/http/nextcloud


RUN chown www-data:www-data -R /srv/http
RUN chmod g+wrs -R /srv/http

COPY caddy_linux_arm7 /usr/bin/caddy
VOLUME /root/.caddy
VOLUME /srv/http/nextcloud/data/
COPY Caddyfile /etc/Caddyfile

EXPOSE 80 443 2015

WORKDIR /srv/http/nextcloud
ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
