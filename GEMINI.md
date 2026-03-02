# HR System - Instruksi untuk Gemini

Aplikasi **Ruby on Rails 7.2** untuk manajemen HR (karyawan, absensi, cuti).

## Tech Stack

- Ruby 3.3.0, Rails 7.2, SQLite
- Stimulus, Turbo, Chart.js, Importmap
- Propshaft, Inter font
- UI bahasa Indonesia

## Perintah

```bash
bundle install
bin/rails db:migrate db:seed
bin/rails server
bin/rails test
```

## Konvensi Kode

- **Helpers**: `icon(:dashboard)`, `breadcrumbs(...)`, `format_currency(n)`, `time_ago_short(t)`
- **Controllers**: `before_action`, `respond_to` HTML/CSV, strong params
- **Models**: enum, scope, Activity.log callback
- **Views**: class `card`, `stat-card`, `btn`, `badge badge-<status>`
- **Stimulus**: data-controller, data-action, data-*-value, data-*-target

## Struktur

- `app/controllers/` - Dashboard, Employees, Attendances, Leaves, Reports, Search
- `app/models/` - Employee, Attendance, Leave, Activity
- `app/helpers/application_helper.rb` - icon, breadcrumbs
- `app/javascript/controllers/` - Stimulus
- Rute: `/`, `/employees`, `/attendances`, `/leaves`, `/reports`, `/search`, `/attendances/calendar`
