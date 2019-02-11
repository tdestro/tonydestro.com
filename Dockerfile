FROM php:5.6-apache
RUN apt-get update
RUN apt-get install -y mono-complete libapache2-mod-mono mono-vbnc -y --no-install-recommends
COPY ./public-html/ /var/www/html
