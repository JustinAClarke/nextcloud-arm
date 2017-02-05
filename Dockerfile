FROM jfuhrmie/nginxbase-arm

LABEL version "1.0"
LABEL maintainer "justin@fuhrmeister-clarke.com"
LABEL description "A Docker Container for nextcloud"

RUN apt-get -y update && apt-get install -y php5-gd php5-json php5-mysql php5-curl php5-intl php5-mcrypt php5-imagick php5-fpm wget gnupg lbzip2 php5-sqlite
#RUN gem install jekyll bundler
RUN mkdir -p /srv/http/nextcloud

#COPY index.html /srv/http/index.html
#COPY moby.svg /srv/http/moby.svg

RUN wget https://nextcloud.com/nextcloud.asc; gpg --import nextcloud.asc

RUN wget https://download.nextcloud.com/server/releases/nextcloud-11.0.1.tar.bz2; wget https://download.nextcloud.com/server/releases/nextcloud-11.0.1.tar.bz2.md5
RUN wget https://download.nextcloud.com/server/releases/nextcloud-11.0.1.tar.bz2.asc; gpg --verify nextcloud-11.0.1.tar.bz2.asc nextcloud-11.0.1.tar.bz2

RUN md5sum -c nextcloud-11.0.1.tar.bz2.md5 < nextcloud-11.0.1.tar.bz2

RUN gpg --verify nextcloud-11.0.1.tar.bz2.asc nextcloud-11.0.1.tar.bz2
RUN tar -xf nextcloud-11.0.1.tar.bz2

RUN cp -r nextcloud /srv/http/

RUN rm -Rf /nextcloud

#RUN sed -i "s|root /srv/http/|root /srv/http/nextcloud/_site|g" /etc/nginx/sites-enabled/default
COPY nextcloud.conf /etc/nginx/sites-available/default
COPY nextcloud.conf /etc/nginx/sites-enabled/default



RUN chown www-data:www-data -R /srv/http
RUN chmod g+wrs -R /srv/http

COPY startup.sh /
RUN chmod o+x /startup.sh

EXPOSE 80 443

# ENTRYPOINT ["/usr/sbin/apachectl", "start"]
ENTRYPOINT ["/startup.sh"]
CMD ["/startup.sh"]

