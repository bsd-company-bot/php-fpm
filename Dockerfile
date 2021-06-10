FROM php:7.4-fpm
LABEL maintainer = "tuyen@bssd.vn"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        git \
        zlib1g-dev \
        libxml2-dev \
        libpng-dev \
        libzip-dev \
        vim curl debconf subversion git apt-transport-https apt-utils \
        build-essential locales acl mailutils wget nodejs zip unzip \
        gnupg gnupg1 gnupg2 \
        sudo \
        ssh \
        argon2 ca-certificates \
    && docker-php-ext-install \
        pdo_mysql \
        soap \
        zip \
        opcache \
        gd \
        intl \
        mysqli

COPY config/opcache.ini /usr/local/etc/php/conf.d/

RUN apt-get -y autoclean && apt-get -y autoremove

RUN usermod -u 1000 www-data
RUN usermod -a -G www-data root
RUN mkdir -p /var/www
RUN chown -R www-data:www-data /var/www
RUN mkdir -p /var/www/.composer
RUN chown -R www-data:www-data /var/www/.composer

USER www-data

WORKDIR /var/www/
