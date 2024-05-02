FROM php:8.2-fpm-alpine

#MAINTAINER hieptv <tranhieptvh@gmail.com>

# Install dependencies
RUN apk --update add wget \
    curl \
    git \
    build-base \
    libmcrypt-dev \
    libxml2-dev \
    linux-headers \
    pcre-dev \
    zlib-dev \
    autoconf \
    cyrus-sasl-dev \
    libgsasl-dev \
    oniguruma-dev \
    libressl \
    libressl-dev \
    supervisor \
    shadow

# Install extensions
RUN pecl channel-update pecl.php.net; \
    docker-php-ext-install mysqli mbstring pdo pdo_mysql xml pcntl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#
RUN pecl install xdebug-3.3.2 \
    && docker-php-ext-enable xdebug

RUN rm /var/cache/apk/*

# Set working directory
WORKDIR /var/www/html

# Expose port 9000
EXPOSE 9000
CMD ["php-fpm"]