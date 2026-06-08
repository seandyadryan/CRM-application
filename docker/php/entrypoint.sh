#!/usr/bin/env sh
set -e

cd /var/www/html

if [ ! -f .env ]; then
  cp .env.example .env
fi

composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

if [ -z "${APP_KEY:-}" ] && ! grep -q '^APP_KEY=base64:' .env; then
  php artisan key:generate --force
fi

if [ "${RUN_MIGRATIONS:-true}" = "true" ]; then
  php artisan migrate --force
fi

if [ "${RUN_SEEDER:-false}" = "true" ]; then
  if ! php -r 'require "vendor/autoload.php"; $app = require "bootstrap/app.php"; $app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap(); exit(App\Models\Customer::count() > 0 ? 0 : 1);'; then
    php artisan db:seed --force
  fi
fi

php artisan config:clear
php artisan route:clear

chown -R www-data:www-data storage bootstrap/cache

exec "$@"
