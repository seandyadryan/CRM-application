# Deploy Backend Laravel ke Ubuntu 24.04 dengan Nginx

Panduan ini untuk backend Laravel di folder `backend` dan database PostgreSQL.

## 1. Paket server

```bash
sudo apt update
sudo apt install -y nginx postgresql postgresql-contrib php8.3-fpm php8.3-cli php8.3-pgsql php8.3-mbstring php8.3-xml php8.3-curl php8.3-zip php8.3-bcmath unzip git curl
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

## 2. Database PostgreSQL

```bash
sudo -u postgres psql
CREATE DATABASE crm_application;
CREATE USER crm_user WITH ENCRYPTED PASSWORD 'change_this_password';
GRANT ALL PRIVILEGES ON DATABASE crm_application TO crm_user;
\q
```

## 3. Aplikasi Laravel

```bash
sudo mkdir -p /var/www/crm-application
sudo chown -R $USER:www-data /var/www/crm-application
git clone https://github.com/seandyadryan/CRM-application.git /var/www/crm-application
cd /var/www/crm-application/backend
composer install --no-dev --optimize-autoloader
cp .env.example .env
php artisan key:generate
```

Isi `.env`:

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.com
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=crm_application
DB_USERNAME=crm_user
DB_PASSWORD=change_this_password
```

Jalankan migration dan optimasi:

```bash
php artisan migrate --seed --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
sudo chown -R www-data:www-data storage bootstrap/cache
```

## 4. Nginx

Buat `/etc/nginx/sites-available/crm-application`:

```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/crm-application/backend/public;

    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

Aktifkan konfigurasi:

```bash
sudo ln -s /etc/nginx/sites-available/crm-application /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

Endpoint cek cepat:

```bash
curl http://your-domain.com/api/workspace
```

Untuk HTTPS, pasang Certbot:

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```
