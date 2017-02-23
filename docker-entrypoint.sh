#!/bin/bash

echo "Fixing Permissions"
chown www-data:www-data -R /srv/http
chmod g+wrs -R /srv/http

echo "Starting PHP-fpm"
php-fpm &

echo "Starting Caddy"
/usr/bin/caddy --conf /etc/Caddyfile --log stdout

exec "$@"
