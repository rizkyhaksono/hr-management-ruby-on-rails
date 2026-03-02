# GitHub Copilot - HR System Instructions

## Project

Ruby on Rails 7.2 HR System: karyawan, absensi, cuti. UI bahasa Indonesia.

## Stack

- Ruby 3.3.0, Rails 7.2, SQLite
- Stimulus, Turbo, Chart.js, Importmap
- Propshaft, Inter font

## Conventions

- **Helpers**: `icon(:name)` (SVG), `breadcrumbs(...)`, `format_currency(n)`, `time_ago_short(t)`
- **Controllers**: `before_action :set_resource`, `respond_to` HTML/CSV
- **Models**: enum status, scope query, Activity.log for audit
- **Views**: `card`, `stat-card`, `btn btn-primary`, `badge badge-<status>`
- **Stimulus**: data-controller, data-action, data-*-value

## File Patterns

- Controllers: `app/controllers/*_controller.rb`
- Models: `app/models/*.rb`, concerns in `app/models/concerns/`
- Views: ERB in `app/views/`
- Stimulus: `app/javascript/controllers/*_controller.js`
