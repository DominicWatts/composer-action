#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM php:7.4-alpine

LABEL repository="https://github.com/MilesChou/composer-action" \
    maintainer="MilesChou <jangconan@gmail.com>"

RUN set -xe && \
    apk add --no-cache \
        shadow \
        curl \
        vim \
        git \
        tree \
        php7 \
        php7-bcmath \
        php7-cli \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-openssl \
        php7-pdo_mysql \
        php7-phar \
        php7-session \
        php7-simplexml \
        php7-soap \
        php7-tokenizer \
        php7-xml \
        php7-xmlwriter \
        php7-xsl \
        php7-zip \
        php7-zlib \
        php7-sockets \
    && \
    apk add --no-cache --virtual .build-deps \
        libzip-dev \
        zlib-dev \
    && \
    docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" \
        zip \
    && \
    apk del --no-cache .build-deps \
    && \
    php -m

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1 \
    COMPOSER_HOME=/tmp \
    COMPOSER_PATH=/usr/local/bin/composer \
    COMPOSER_VERSION=1.10.5

COPY --from=composer:1.10.5 /usr/bin/composer /usr/local/bin/composer

RUN set -xe && \
        composer global require hirak/prestissimo && \
        composer clear-cache

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

CMD ["--info"]