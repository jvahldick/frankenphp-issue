FROM dunglas/frankenphp:sha-7454826-php8.3.2-alpine AS base

ARG APP_CODE_PATH_CONTAINER=/app

RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime && echo UTC > /etc/timezone

RUN apk update \
    && apk add --no-cache $PHPIZE_DEPS \
    && apk add zip git openssh-client bash postgresql-dev curl libzip-dev libpng-dev

RUN docker-php-ext-install pdo pdo_pgsql pgsql zip gd; \
    docker-php-ext-enable opcache

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN mkdir -p ${APP_CODE_PATH_CONTAINER}

ARG APP_ENV=dev
COPY build/docker/workspace/conf/${APP_ENV}.ini /usr/local/etc/php/conf.d/${APP_ENV}.ini
COPY build/docker/workspace/conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY build/docker/workspace/conf/Caddyfile /etc/caddy/Caddyfile

# Install symfony cli
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony \
    && chmod +x /usr/local/bin/symfony

WORKDIR ${APP_CODE_PATH_CONTAINER}
