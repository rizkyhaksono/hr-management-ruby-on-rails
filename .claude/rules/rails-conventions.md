---
paths: app/**/*.rb, config/**/*.rb, db/**/*.rb
---

# Rails Conventions

- Strong parameters di `*_params` method
- `before_action :set_resource` untuk resource controllers
- `respond_to` untuk HTML dan CSV
- Model callbacks untuk Activity: `after_create_commit { Activity.log(...) }`
- Scope dan enum untuk query dan status
