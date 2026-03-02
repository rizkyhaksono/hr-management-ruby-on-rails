# HR System - Sistem Manajemen Sumber Daya Manusia

Aplikasi web berbasis Ruby on Rails untuk mengelola data karyawan, absensi, dan cuti dalam satu sistem terintegrasi.

## 📋 Daftar Isi

- [Fitur](#-fitur)
- [Persyaratan Sistem](#-persyaratan-sistem)
- [Instalasi](#-instalasi)
- [Konfigurasi](#-konfigurasi)
- [Database](#-database)
- [Menjalankan Aplikasi](#-menjalankan-aplikasi)
- [Pengujian](#-pengujian)
- [Struktur Proyek](#-struktur-proyek)
- [Deployment](#-deployment)

---

## ✨ Fitur

### 1. Dashboard HR
- Ringkasan statistik: total karyawan, karyawan aktif, cuti pending, hadir hari ini
- Grafik distribusi karyawan per departemen
- Ringkasan absensi hari ini dan cuti terbaru

### 2. Manajemen Karyawan (Employees)
- CRUD lengkap data karyawan
- Fitur pencarian dan filter (departemen, status)
- Status karyawan: aktif, nonaktif, cuti, terminated
- Informasi: ID karyawan, nama, email, telepon, departemen, posisi, tanggal bergabung, gaji

### 3. Manajemen Cuti (Leaves)
- Pengajuan cuti dengan berbagai jenis: tahunan, sakit, pribadi, melahirkan, ayah baru, tidak dibayar
- Approval/reject permohonan cuti
- Validasi tanggal tumpang tindih
- Status: pending, approved, rejected, cancelled

### 4. Manajemen Absensi (Attendances)
- Pencatatan check-in dan check-out
- Bulk create absensi untuk tanggal tertentu
- Status: present, absent, late, half_day, remote
- Perhitungan jam kerja otomatis

---

## 🔧 Persyaratan Sistem

| Komponen       | Versi           |
|----------------|-----------------|
| Ruby           | 3.3.0           |
| Rails          | ~> 7.2.0        |
| SQLite         | >= 3.8.0        |
| Node.js        | (opsional, untuk asset pipeline) |

### Dependensi Sistem

- **Ruby 3.3.0** — [rbenv](https://github.com/rbenv/rbenv) atau [rvm](https://rvm.io/) disarankan
- **SQLite3** — Database default
- **Bundler** — Untuk dependency management

---

## 📥 Instalasi

### 1. Clone Repository

```bash
git clone <repository-url>
cd ruby-on-rails-tutorial
```

### 2. Pastikan Ruby 3.3.0 Terpasang

```bash
# Menggunakan rbenv
rbenv install 3.3.0
rbenv local 3.3.0

# Atau dengan rvm
rvm install 3.3.0
rvm use 3.3.0
```

### 3. Instalasi Dependensi

```bash
bundle install
```

### 4. Setup Database

```bash
# Buat database, jalankan migrasi, dan seed data
bin/rails db:create db:migrate db:seed
```

---

## ⚙️ Konfigurasi

### Database

Konfigurasi database ada di `config/database.yml`. Default menggunakan SQLite:

- **Development**: `storage/development.sqlite3`
- **Test**: `storage/test.sqlite3`
- **Production**: `storage/production.sqlite3`

Untuk mengubah ke PostgreSQL atau MySQL, edit `config/database.yml` dan `Gemfile`.

### Variabel Lingkungan

- `RAILS_ENV` — Environment (development/test/production)
- `RAILS_MAX_THREADS` — Jumlah thread Puma (default: 5)

---

## 🗄️ Database

### Migrasi

```bash
# Jalankan semua migrasi
bin/rails db:migrate

# Rollback migrasi terakhir
bin/rails db:rollback

# Reset database (hapus, buat ulang, migrate)
bin/rails db:reset
```

### Seed Data

Database seed berisi contoh data:
- 15 karyawan dari berbagai departemen
- Data cuti (berbagai status dan tipe)
- Data absensi untuk 7 hari terakhir (hari kerja)

```bash
bin/rails db:seed
```

---

## 🚀 Menjalankan Aplikasi

### Development Server

```bash
bin/rails server
# atau
bundle exec rails s
```

Aplikasi berjalan di **http://localhost:3000**

### Alternatif dengan Binding

Untuk mengakses dari device lain di jaringan:

```bash
bin/rails server -b 0.0.0.0
```

### Rails Console

```bash
bin/rails console
# atau
bundle exec rails c
```

### Rute Utama

| Path                  | Deskripsi            |
|-----------------------|----------------------|
| `/`                   | Dashboard            |
| `/employees`          | Daftar karyawan      |
| `/employees/new`      | Tambah karyawan      |
| `/leaves`             | Daftar cuti          |
| `/attendances`        | Daftar absensi       |
| `/attendances/bulk_create` | Bulk create absensi |
| `/up`                 | Health check         |

---

## 🧪 Pengujian

### Menjalankan Test Suite

```bash
# Semua test
bin/rails test
# atau
bundle exec rails test

# Test spesifik
bin/rails test test/models/employee_test.rb
bin/rails test test/models/attendance_test.rb
bin/rails test test/models/leave_test.rb
```

### Tools Pengembangan

- **Brakeman** — Security scan: `bundle exec brakeman`
- **RuboCop** — Linting: `bundle exec rubocop`
- **Bundler Audit** — Cek vulnerability gem: `bundle exec bundler-audit`

---

## 📁 Struktur Proyek

```
ruby-on-rails-tutorial/
├── app/
│   ├── controllers/       # Dashboard, Employees, Leaves, Attendances
│   ├── models/            # Employee, Leave, Attendance + Concerns
│   ├── views/             # ERB templates
│   └── assets/
├── config/
│   ├── routes.rb          # Routing aplikasi
│   ├── database.yml       # Konfigurasi database
│   └── deploy.yml        # Konfigurasi Kamal deployment
├── db/
│   ├── migrate/           # Migration files
│   ├── schema.rb          # Schema database
│   └── seeds.rb           # Data awal
├── test/                  # Unit & model tests
└── .kamal/               # Kamal deployment hooks
```

---

## 🚢 Deployment

Proyek ini menggunakan **Kamal** untuk deployment berbasis Docker.

### Persiapan

1. Pastikan server target tersedia (IP di `config/deploy.yml`)
2. Setup `.kamal/secrets` dengan `RAILS_MASTER_KEY`
3. Konfigurasi registry (default: localhost:5555)

### Deploy dengan Kamal

```bash
# Setup awal
bin/kamal setup

# Deploy
bin/kamal deploy
```

### Perintah Kamal Berguna

```bash
bin/kamal console    # Rails console di production
bin/kamal shell     # Bash shell di container
bin/kamal logs      # Tail logs aplikasi
bin/kamal dbc       # Database console
```

---

## 📝 Lisensi

Proyek ini dibuat sebagai pembelajaran Ruby on Rails Tutorial.

---

## 🤝 Kontribusi

1. Fork repository
2. Buat branch fitur (`git checkout -b feature/nama-fitur`)
3. Commit perubahan (`git commit -m 'Tambahkan fitur X'`)
4. Push ke branch (`git push origin feature/nama-fitur`)
5. Buat Pull Request
