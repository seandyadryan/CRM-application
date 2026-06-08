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

## Menjalankan Backend dengan Docker

Pastikan Docker dan Docker Compose sudah terinstall.

```bash
cd CRM-application
docker compose up -d --build
```

Container yang berjalan:

- `crm_nginx` - Nginx, akses API di port `8080`.
- `crm_app` - Laravel PHP-FPM.
- `crm_postgres` - PostgreSQL, port host `5433`.

Tes di Postman:

```text
GET http://localhost:8080/api/workspace
```

Kalau menjalankan dari server, ganti `localhost` dengan IP server:

```text
GET http://SERVER_IP:8080/api/workspace
```

Melihat log:

```bash
docker compose logs -f app
docker compose logs -f nginx
```

Stop container:

```bash
docker compose down
```

Reset database Docker:

```bash
docker compose down -v
docker compose up -d --build
```

Menjalankan Flutter ke backend Docker lokal:

```powershell
cd D:\GITHUB\CRM-application\crm_mobile
C:\Users\seandy.nugraha\fvm\versions\3.41.2\bin\flutter.bat run --dart-define=API_BASE_URL=http://localhost:8080/api
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
