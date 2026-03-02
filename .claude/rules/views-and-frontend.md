---
paths: app/views/**/*.erb, app/assets/**/*.css, app/javascript/**/*.js
---

# Views & Frontend

- Gunakan `icon(:name)` helper, jangan emoji
- Breadcrumbs via `content_for(:breadcrumbs)`
- Pagination: `render "shared/pagination", total_pages:, current_page:`
- Stimulus: data-controller, data-action, data-*-value, data-*-target
- CSS: var(--primary-500), [data-theme="dark"], animate-fade-in-up
