#!/bin/bash

chown www-data:www-data -R /srv/http/; chmod g+rws -R /srv/http/

result=`ps aux | grep -i "nginx" | grep -v "grep" | wc -l`
if [ $result -ge 1 ]
   then
        echo "nginx is running"
   else
        nginx &
	php-fpm &
fi

result=`ps aux | grep -i "php-fpm" | grep -v "grep" | wc -l`
if [ $result -ge 1 ]
   then
        echo "php-fpm is running"
   else
        php-fpm &
fi

exec "$@"

