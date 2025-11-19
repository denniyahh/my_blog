
# Dev Environment Inventory

This document captures the current toolchain inside `myblog-devpod` so it can be reproduced with a Nix flake or other declarative setup. Updated after the LAN/Vite fixes on 2025-11-19.

## Ruby Toolchain
- Ruby: `ruby 3.3.9` (Gemfile target; `ruby 3.4.6` also available in RVM)
- Bundler: `2.7.2`
- Jekyll (bundled): `3.10.0`
- Bundler binstubs in `bin/` (`jekyll`, `htmlproofer`, `rubocop`, `standardrb`, `ruby-lsp`, etc.)
- Verified commands: `bundle exec jekyll build --config _config.yml,_config.ci.yml`, `bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload --livereload-port 35730 --force_polling`, `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`

## Node & JavaScript Tooling
- Node.js: `v22.20.0` (NVM @ `/usr/local/share/nvm/versions/node/v22.20.0`)
- npm: `10.9.3`
- Global npm packages (`npm list -g --depth=0`): `@openai/codex@0.50.0`, `corepack@0.34.0`, `markdownlint-cli2@0.18.1`, `npm@10.9.3`, `pnpm@10.18.0`
- Additional CLIs via `npx`: `@lhci/cli` (Lighthouse), `@axe-core/cli` (optional a11y), `sharp-cli`/`cwebp` (image compression)

## Editor & CLI Utilities
- Neovim: `NVIM v0.11.4`
- Python: `3.11.2`
- tmux: `3.5a`
- Codex CLI: `/usr/local/share/nvm/current/bin/codex`
- Shell helpers: `fzf`, git extras, etc.

## Services & Processes
- Dev server: `bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload --livereload-port 35730 --force_polling`
- Vite dev server: `pnpm dev` (binds to `0.0.0.0:5173`, head template now binds to the request host dynamically)
- Port forwarding (LAN/mobile QA): run in tmux — `devpod ssh myblog-devpod --start-services=false --forward-ports 0.0.0.0:4000:127.0.0.1:4000 --forward-ports 0.0.0.0:35730:127.0.0.1:35730 --forward-ports 0.0.0.0:5173:127.0.0.1:5173 --command 'sleep 1d'`
- Validation workflow:
  1. `bundle exec jekyll build --config _config.yml,_config.ci.yml`
  2. `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`
  3. `npx markdownlint-cli2 "**/*.md"`
  4. `npx @lhci/cli collect --url http://127.0.0.1:4000`
  5. Capture screenshots/video from Chrome DevTools (iPhone 12 preset)

## Repo Structure Notes
- Minima theme copied into `_layouts/`, `_includes/`, `_sass/`, and `assets/`.
- Feature specs live under `docs/specs/` with active item `001-mobile-first-redesign`.
- Documentation spans `docs/theme-spec.md`, `docs/work-plan.md`, and this inventory.
- `_site/`, `.ruby-lsp/`, `node_modules/`, etc. stay ignored per `.gitignore`.

## Outstanding Migration Questions
- Decide whether to bring `sharp-cli`/`cwebp` into Nix/flake configuration or rely on ad-hoc installation.
- Determine Node package management strategy (Nix `nodePackages`, `pnpm`, or `corepack`).
- Capture Neovim configuration dependencies (Treesitter grammars, Mason-managed LSP servers) if they should be provisioned declaratively.
- Confirm whether accessibility tooling (`@axe-core/cli`) becomes a hard requirement in CI or remains optional.
