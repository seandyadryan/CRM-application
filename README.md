# CRM Application

Project CRM modern berisi aplikasi mobile Flutter dan backend Laravel API.

## Struktur

- `crm_mobile` - Flutter 3.41.2, Dart 3.11, UI mobile modern dengan pola MVC.
- `backend` - Laravel API untuk PostgreSQL.
- `database/postgresql_schema.sql` - script SQL PostgreSQL manual.
- `docs/DEPLOY_UBUNTU_24_04_NGINX.md` - panduan deploy Laravel di Ubuntu 24.04 dengan Nginx.

## Menjalankan Flutter

```powershell
cd D:\GITHUB\CRM-application\crm_mobile
C:\Users\seandy.nugraha\fvm\versions\3.41.2\bin\flutter.bat pub get
C:\Users\seandy.nugraha\fvm\versions\3.41.2\bin\flutter.bat run
```

Jika backend berada di server:

```powershell
C:\Users\seandy.nugraha\fvm\versions\3.41.2\bin\flutter.bat run --dart-define=API_BASE_URL=https://your-domain.com/api
```

## Menjalankan Backend

Di Ubuntu/server yang sudah memiliki PHP 8.3, Composer, dan PostgreSQL:

```bash
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

Endpoint utama:

```text
GET /api/workspace
GET /api/customers
GET /api/leads
GET /api/deals
GET /api/activities
```

## Catatan

PHP dan Composer belum tersedia di mesin Windows ini, jadi instalasi dependency backend dilakukan saat deploy di Ubuntu. Source Laravel, migration, seeder, API routes, dan controller sudah disiapkan.
