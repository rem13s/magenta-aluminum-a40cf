# Hugo Lime

Static site built with [Hugo](https://gohugo.io/) and the [Hugo Lime](themes/hugo%20lime/) theme. Site content is configured via JSON files in `data/`.

## Prerequisites

- **Hugo Extended** (required for SCSS compilation)
- **Hugo v0.127.x** — this theme uses `resources.ToCSS`, which was removed in newer Hugo versions

## Local development

From the project root, start the development server:

```powershell
.\.tools\hugo-127\hugo.exe server -D
```

Open [http://localhost:1313/](http://localhost:1313/). The server watches `content/`, `data/`, and `themes/` for changes. Press `Ctrl+C` to stop.

If Hugo is installed globally and on your `PATH`:

```powershell
hugo server -D
```

## Build

Generate the static site into `public/`:

```powershell
.\.tools\hugo-127\hugo.exe
```

Or, with a global Hugo install:

```powershell
hugo
```

The output is written to `public/`, matching the Netlify build in `netlify.toml`.

## Installing Hugo locally

If `.tools/hugo-127/` is not present, download Hugo Extended v0.127.0 for Windows:

```powershell
$toolsDir = ".tools\hugo-127"
New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null
$zip = ".tools\hugo-127.zip"
Invoke-WebRequest -Uri "https://github.com/gohugoio/hugo/releases/download/v0.127.0/hugo_extended_0.127.0_windows-amd64.zip" -OutFile $zip
Expand-Archive -Path $zip -DestinationPath $toolsDir -Force
```

Alternatively, install Hugo Extended from the [official installation guide](https://gohugo.io/installation/windows/).
