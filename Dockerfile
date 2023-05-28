FROM php:8.2-alpine

RUN apk update && apk upgrade && apk add git

RUN git clone https://github.com/stecklars/dynamic-dns-netcup-api

WORKDIR ./dynamic-dns-netcup-api

RUN chmod u+x update.php

RUN crontab -l | { cat; echo "* * * * * bash update.php"; } | crontab -
 
CMD ["/usr/sbin/crond", "-f"]