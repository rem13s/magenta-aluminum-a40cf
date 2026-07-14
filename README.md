# Green paper

Static site built with [Hugo](https://gohugo.io/) and the [Hugo Up Business](themes/hugo-up-business/) theme (Tailwind CSS v4). Site content is configured via YAML files in `data/home/` and `config/_default/`.

## Prerequisites

- **Hugo Extended v0.148+** (uses `css.TailwindCSS`)
- **Node.js v22+** (required for Tailwind CSS processing)

Portable tooling is available under `.tools/` for local development on Windows.

## Local development

Install Node dependencies, then start the development server:

```powershell
npm install
.\.tools\hugo-148\hugo.exe server -D
```

Open [http://localhost:1313/](http://localhost:1313/). The server watches `content/`, `data/`, `config/`, `layouts/`, and `themes/` for changes. Press `Ctrl+C` to stop.

If Hugo and Node.js are installed globally:

```powershell
npm install
hugo server -D
```

## Build

Generate the static site into `public/`:

```powershell
npm install
.\.tools\hugo-148\hugo.exe --gc --minify
```

Or, with global installs:

```powershell
npm install
hugo --gc --minify
```

The output is written to `public/`, matching the Netlify build in `netlify.toml`.

## Installing Hugo locally

If `.tools/hugo-148/` is not present, download Hugo Extended v0.148.2 for Windows:

```powershell
$toolsDir = ".tools\hugo-148"
New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null
$zip = ".tools\hugo-148.zip"
Invoke-WebRequest -Uri "https://github.com/gohugoio/hugo/releases/download/v0.148.2/hugo_extended_0.148.2_windows-amd64.zip" -OutFile $zip
Expand-Archive -Path $zip -DestinationPath $toolsDir -Force
```

Alternatively, install Hugo Extended from the [official installation guide](https://gohugo.io/installation/windows/).

## Content structure

| Path | Purpose |
|------|---------|
| `config/_default/` | Site title, menus, params |
| `data/home/` | Homepage sections (hero, services, pricing, team, brands, contact) |
| `layouts/` | Custom section overrides |
| `assets/images/` | Site images and illustrations |

## Theme

This project uses [Hugo Up Business](https://github.com/writeonlycode/hugo-up-business) — a modern landing page theme built with Tailwind CSS, compatible with Hugo v0.148+.
