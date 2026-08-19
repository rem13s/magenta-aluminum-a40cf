# Ekaterina Mihailova

Single-page [Hugo](https://gohugo.io/) site for consultations and booking. The layout follows a landing-page design: hero, booking bar, about, process, pricing, results, case studies, reviews, education, and contact.

## Local development

Global `npm` and `hugo` are not required:

```powershell
.\dev.ps1
```

Open [http://localhost:1313/](http://localhost:1313/).

## Build

```powershell
.\build.ps1
```

Output goes to `public/`, matching `netlify.toml`.

## Content

| Path | Purpose |
|------|---------|
| `data/site/` | Text for all sections (hero, about, pricing, …) |
| `config/_default/params.yaml` | Site colors and settings |
| `assets/images/` | Photos and illustrations |
| `layouts/partials/sections/` | Page section HTML |
| `assets/css/site.css` | Layout styles |

### Replacing photos

Place files in `assets/images/` using the names from `data/site/*.yaml`:

- `hero-ekaterina.jpg`, `intro-ekaterina.jpg`, `about-ekaterina.jpg`, …
- `cert-1.jpg`, `cert-2.jpg` — certificates
- `case-sleep.jpg`, `case-confidence.jpg` — case studies

Placeholder images are used for now.

## Hugo

Portable Hugo 0.148.2 lives in `.tools/hugo-148/`. The `dev.ps1` and `build.ps1` scripts download it on first run.
