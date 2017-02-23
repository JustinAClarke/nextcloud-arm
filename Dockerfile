FROM armhf/php:7.1-fpm

LABEL version "1.0"
LABEL maintainer "justin@fuhrmeister-clarke.com"
LABEL description "A Docker Container for nextcloud"

RUN apt-get update && apt-get install -y \
  bzip2 \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg-dev \
  libldap2-dev \
  libmcrypt-dev \
  libmemcached-dev \
  libpng12-dev \
  libpq-dev \
  libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

# https://docs.nextcloud.com/server/9/admin_manual/installation/source_installation.html
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd exif intl mbstring mcrypt pdo_mysql opcache  pdo_pgsql pgsql zip

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=60'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini

                                            
#RUN gem install jekyll bundler
RUN mkdir -p /srv/http/nextcloud


COPY nextcloud /srv/http/nextcloud


RUN chown www-data:www-data -R /srv/http
RUN chmod g+wrs -R /srv/http

COPY caddy_linux_arm7 /usr/bin/caddy
COPY Caddyfile /etc/Caddyfile
COPY docker-entrypoint.sh /

VOLUME /root/.caddy
VOLUME /srv/http/nextcloud/data/
VOLUME /srv/http/nextcloud/config/

EXPOSE 80 443 2015

ENTRYPOINT ["/docker-entrypoint.sh"]
