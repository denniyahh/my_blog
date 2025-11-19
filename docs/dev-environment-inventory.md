# Dev Environment Inventory

This document captures the current toolchain inside `myblog-devpod` so it can be reproduced with a Nix flake or other declarative setup. Updates on 2025-11-06 align the environment with the `001-mobile-first-redesign` spec.

## Ruby Toolchain
- Ruby: `ruby 3.4.6 (2025-09-16 revision dbd83256b1) +PRISM [x86_64-linux]`
- Bundler: `2.7.2`
- Jekyll (bundled): `3.10.0`
- Bundler binstubs in `bin/` (`jekyll`, `htmlproofer`, `rubocop`, `standardrb`, `ruby-lsp`, etc.)
- Verified commands for spec: `bundle exec jekyll build --config _config.yml,_config.ci.yml`, `bundle exec jekyll serve --livereload`, `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`

## Node & JavaScript Tooling
- Node.js: `v22.20.0` (NVM @ `/usr/local/share/nvm/versions/node/v22.20.0`)
- npm: `10.9.3`
- Global npm packages (`npm list -g --depth=0`):
  - `@openai/codex@0.50.0`
  - `corepack@0.34.0`
  - `markdownlint-cli2@0.18.1`
  - `npm@10.9.3`
  - `pnpm@10.18.0`
- Additional CLIs run via `npx` per feature spec:
  - `@lhci/cli` for Lighthouse Mobile evidence (`npx @lhci/cli collect --url http://127.0.0.1:4000`)
  - `@axe-core/cli` (optional) for accessibility smoke tests
  - `sharp-cli` or `cwebp` for image compression (install locally before asset work)

## Editor & CLI Utilities
- Neovim: `NVIM v0.11.4` (Treesitter + html/css/tailwind LSPs recommended for layout work)
- Python: `3.11.2` (supports html-proofer deps + scripting)
- tmux: `3.3a`
- Codex CLI: `/usr/local/share/nvm/current/bin/codex`
- Shell helpers: `fzf`, git extras, etc.

## Services & Processes
- Dev server: `bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload --livereload-port 35730 --force_polling`
- Port forwarding: `devpod ssh ... -L 0.0.0.0:4000:localhost:4000 -L 0.0.0.0:35730:localhost:35730 --command 'sleep infinity'`
- Validation workflow (per spec):
  1. `bundle exec jekyll build --config _config.yml,_config.ci.yml`
  2. `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`
  3. `npx markdownlint-cli2 "**/*.md"`
  4. `npx @lhci/cli collect --url http://127.0.0.1:4000`
  5. Capture screenshots/video from Chrome DevTools (iPhone 12 preset)
- Helper script: `.specify/scripts/bash/build-mobile-preview.sh` wraps the steps above so agents can run them unattended (build, htmlproofer, markdownlint, Lighthouse).

## Repo Structure Notes
- Minima theme copied into `_layouts/`, `_includes/`, `_sass/`, and `assets/`.
- Feature specs now live under `docs/specs/` (moved from repo root) with active item `001-mobile-first-redesign`.
- Documentation for redesign spans `docs/theme-spec.md`, `docs/work-plan.md`, and `docs/dev-environment-inventory.md` (this file).
- `_site/`, `.ruby-lsp/`, `node_modules/`, etc. stay ignored per `.gitignore`.

## Outstanding Migration Questions
- Decide whether to bring `sharp-cli`/`cwebp` into Nix/flake configuration or rely on ad-hoc installation.
- Determine Node package management strategy (Nix `nodePackages`, `pnpm`, or `corepack`).
- Capture Neovim configuration dependencies (Treesitter grammars, Mason-managed LSP servers) if they should be provisioned declaratively.
- Confirm whether accessibility tooling (`@axe-core/cli`) becomes a hard requirement in CI or remains optional.
