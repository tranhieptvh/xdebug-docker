FROM php:7.4-fpm-alpine

MAINTAINER Kaopiz <kaopiz.com>

WORKDIR /var/www

# Install dependencies
RUN apk add wget \
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
  supervisor\
  unzip\
  libzip-dev\
  libpng \
  libjpeg-turbo \
  freetype-dev \
  libpng-dev \
  libjpeg-turbo-dev \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip


RUN pecl channel-update pecl.php.net; \
  docker-php-ext-install pdo pdo_mysql mysqli mbstring pdo pdo_mysql tokenizer xml exif pcntl gd zip



# Install composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

ARG DEBUG=false
ENV DEBUG ${DEBUG}

RUN if [ ${DEBUG} = true ]; then \
    pecl install xdebug \
    && \
    docker-php-ext-enable xdebug \
    ;fi

RUN rm /var/cache/apk/*

COPY . /var/www

COPY ./docker/supervisor/admin_worker.conf /etc/supervisord.conf

COPY ./docker/php/custom.ini /usr/local/etc/php/conf.d/custom.ini

ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN addgroup -g ${PUID} -S www-docker \
    && adduser -u ${PUID} -D -S -G www-docker www-docker

RUN chown -R www-docker:www-docker /var/www

RUN chown -R www-docker:www-docker /var/www/storage/logs

WORKDIR /var/www

USER www-docker

RUN composer install --no-scripts --no-autoloader

RUN composer dump-autoload --optimize

EXPOSE 9000

CMD supervisord -n -c /etc/supervisord.conf
