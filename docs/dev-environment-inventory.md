# Dev Environment Inventory

This document captures the current toolchain inside `myblog-devpod` so it can be reproduced with a Nix flake or other declarative setup.

## Ruby Toolchain
- Ruby: `ruby 3.4.6 (2025-09-16 revision dbd83256b1) +PRISM [x86_64-linux]`
- Bundler: `2.7.2`
- Jekyll (bundled): `3.10.0`
- Bundler binstubs in `bin/` (generated via `bundle binstubs`): `jekyll`, `htmlproofer`, `rubocop`, `standardrb`, `ruby-lsp`, etc.
- Gems managed through repository `Gemfile` (pinned via `Gemfile.lock`, includes `github-pages`, `html-proofer`, `ruby-lsp`, `standardrb`).

## Node & JavaScript Tooling
- Node.js: `v22.20.0` (provided by NVM at `/usr/local/share/nvm/versions/node/v22.20.0`)
- npm: `10.9.3`
- Global npm packages (`npm list -g --depth=0`):
  - `@openai/codex@0.50.0`
  - `corepack@0.34.0`
  - `markdownlint-cli2@0.18.1`
  - `npm@10.9.3`
  - `pnpm@10.18.0`
- Project-level `package-lock.json` currently only tracks markdown lint tooling (no `node_modules/` committed).

## Editor & CLI Utilities
- Neovim: `NVIM v0.11.4`
- Python: `3.11.2` (for tooling such as `html-proofer` dependencies)
- tmux: `3.3a`
- Codex CLI: `/usr/local/share/nvm/current/bin/codex`
- Shell enhancements: `fzf` completion (loaded via `.bashrc`).

## Services & Processes
- Jekyll dev server typically launched with `bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload --livereload-port 35730 --force_polling`.
- Tunnel/port forwarding handled via `devpod ssh … -L 0.0.0.0:4000:localhost:4000 -L 0.0.0.0:35730:localhost:35730 --command 'sleep infinity'`.
- Host firewall (`firewalld`) allows inbound TCP on ports `4000` and `35730` in the `home` zone.

## Repo Structure Notes
- Minima theme copied locally into `_layouts/`, `_includes/`, `_sass/`, and `assets/`.
- Documentation for redesign lives in `docs/theme-spec.md` and `docs/work-plan.md`.
- Generated artifacts ignored via `.gitignore`: `_site/`, caches, `.ruby-lsp/`, `node_modules/`, binstubs, etc.

## Outstanding Migration Questions
- Decide whether to build Ruby gems via Bundler within Nix or precompile with `bundix`.
- Determine Node package management strategy (Nix `nodePackages`, `pnpm`, or use `corepack`).
- Capture Neovim configuration dependencies (Treesitter grammars, LSP servers via Mason) if they should be provisioned declaratively.
