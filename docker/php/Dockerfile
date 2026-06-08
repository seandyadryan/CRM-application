FROM php:8.3-fpm-bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libpq-dev \
        libzip-dev \
        libicu-dev \
    && docker-php-ext-install \
        bcmath \
        intl \
        opcache \
        pdo_pgsql \
        zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY backend/composer.json ./
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader --no-scripts

COPY backend .
COPY docker/php/entrypoint.sh /usr/local/bin/crm-entrypoint

RUN chmod +x /usr/local/bin/crm-entrypoint \
    && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

ENTRYPOINT ["crm-entrypoint"]
CMD ["php-fpm"]
