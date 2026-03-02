# HR System - Instruksi untuk Claude

Proyek ini adalah aplikasi **Ruby on Rails 7.2** untuk manajemen HR: karyawan, absensi, dan cuti.

## Tech Stack

- Ruby 3.3.0, Rails 7.2
- SQLite (dev/test)
- Stimulus, Turbo, Chart.js, Importmap
- Propshaft, Inter font

## Perintah Umum

```bash
bundle install
bin/rails db:migrate db:seed
bin/rails server          # http://localhost:3000
bin/rails test
bundle exec rubocop
bundle exec brakeman
```

## Konvensi

- **Bahasa UI**: Indonesia
- **Helpers**: `icon(:dashboard)`, `breadcrumbs(...)`, `format_currency(n)`, `time_ago_short(t)`
- **Models**: Employee, Attendance, Leave, Activity (polymorphic trackable)
- **Views**: Gunakan class `card`, `stat-card`, `btn`, `badge badge-<status>`

## Rute Penting

- `/` Dashboard
- `/employees` CRUD karyawan
- `/attendances` Absensi + bulk_create, calendar
- `/leaves` Cuti + approve/reject
- `/reports` Laporan dengan chart
- `/search?q=` Pencarian global

## File Penting

- `config/routes.rb` - Routing
- `app/helpers/application_helper.rb` - icon(), breadcrumbs()
- `app/models/concerns/paginatable.rb` - page_records, total_pages
- `app/javascript/controllers/` - Stimulus controllers
