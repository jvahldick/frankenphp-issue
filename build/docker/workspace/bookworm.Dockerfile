FROM dunglas/frankenphp:sha-7454826-php8.3.2-bookworm AS base

ARG APP_CODE_PATH_CONTAINER=/app

RUN ln -snf /usr/share/zoneinfo/UTC /etc/localtime && echo UTC > /etc/timezone

RUN apt-get update && apt-get install -y gnupg \
    && sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install --no-install-recommends --assume-yes zip git openssh-client bash postgresql-15

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
