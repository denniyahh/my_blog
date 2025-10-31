# my_blog

Personal site built with Jekyll and a modern frontend toolchain.

## Prerequisites

- Ruby (3.4+) with Bundler (`bundle install`)
- Node.js (20+) with pnpm (`pnpm install`)
- Optional: `nix develop` if you want the reproducible dev shell defined in `flake.nix`

## Local Development

1. Install dependencies:
   ```bash
   bundle install
   pnpm install
   ```
2. Start the asset pipeline:
   ```bash
   pnpm dev
   ```
3. In another terminal, run Jekyll (an alias `jkserve` is defined in `~/.zshrc`):
   ```bash
   bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload --livereload-port 35730 --force_polling
   ```
   When `jekyll serve` runs in development mode and the Vite dev server is active, pages load assets directly from `http://127.0.0.1:5173/`.

## Production Build

1. Build frontend assets:
   ```bash
   pnpm run build
   ```
2. Build the static site:
   ```bash
   bundle exec jekyll build --config _config.yml,_config.ci.yml
   ```
   The generated site lives in `_site/`.

## Project Structure

- `assets/js`, `assets/css` – TypeScript and Tailwind sources compiled by Vite.
- `assets/dist` – Compiled CSS/JS bundles (ignored in git, regenerated per build).
- `_layouts`, `_includes`, `_sass` – Jekyll theme files (copied from Minima and now customized locally).
- `docs/` – Design spec, work plan, and environment inventory.
