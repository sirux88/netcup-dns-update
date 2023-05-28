FROM php:8.2-alpine

RUN apk update && apk upgrade && apk add git

RUN git clone https://github.com/stecklars/dynamic-dns-netcup-api

WORKDIR ./dynamic-dns-netcup-api



COPY config.php config.php
COPY entrypoint.sh entrypoint.sh

RUN chmod u+x update.php entrypoint.sh

RUN crontab -l | { cat; echo "*/15 * * * * sh /dynamic-dns-netcup-api/entrypoint.sh"; } | crontab -
 
CMD ["/usr/sbin/crond", "-f"]