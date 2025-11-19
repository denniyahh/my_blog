# Repository Guidelines

## Project Structure & Module Organization
The site follows the GitHub Pages Jekyll layout. Source markdown lives at the root (`index.md` for the landing page, `about.md` for the profile), while long-form content belongs in `_posts/` using the `YYYY-MM-DD-slug.md` pattern. Global settings sit in `_config.yml` with CI overrides in `_config.ci.yml`. Automation resides under `.github/workflows/`, and formatter settings are tracked in `.editorconfig` and `.markdownlint-cli2.yaml`. Generated output in `_site/` is disposable—never edit it by hand.

## Build, Test, and Development Commands
- `bundle install` — install Ruby 3.3.9 dependencies defined in the `Gemfile`.
- `bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload --livereload-port 35730 --force_polling` — run the site with live reload bound to all interfaces (LAN/mobile QA).
- `pnpm dev` — start the Vite dev server on 0.0.0.0:5173 (dynamic dev asset host).
- `bundle exec jekyll build --trace` — create a production build in `_site/` with verbose diagnostics.
- `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https` — validate internal links and markup after a build.

## Coding Style & Naming Conventions
Two-space indentation, LF endings, and trimmed whitespace are enforced via `.editorconfig`. Posts always start with YAML front matter declaring `title` and optional `description`. Stick to GitHub Flavored Markdown (set through kramdown) and keep heading levels consistent. Inline HTML is allowed for complex layouts; pair it with semantic classes from Minima when possible. Reference images from an `assets/` folder and use hyphenated filenames.

## Testing Guidelines
Mirror CI by running `bundle exec jekyll build --config _config.yml,_config.ci.yml` before checks. Follow up with the html-proofer command above to catch broken anchors or HTML regressions. Markdownlint (`npx markdownlint-cli2 "**/*.md"`) and Lychee link checks both run in GitHub Actions; resolve any warnings locally to keep pipelines green. For new features, add sample content or fixtures under `_posts/` to exercise the changes.

## DevPod Default Context
Unless a task explicitly says otherwise, run all commands from inside the `myblog-devpod` workspace (reachable via `ssh myblog-devpod.devpod` or `devpod ssh myblog-devpod`). Host-level commands should only be used when the instructions call them out specifically.
Run remote shell commands as the `vscode` user (the default devpod account) by wrapping them in `bash -lc '…'` so the devpod loads `.bash_profile`/`.profile` and inherits the full environment (Nix, pnpm, aliases).
When executing any command via SSH, use the pattern `ssh myblog-devpod.devpod "bash -lic 'cd /workspaces/myblog-devpod && direnv exec . <command>'"` so the working directory and Nix devshell are always set correctly.
When updating Markdown lint rules, edit `.markdownlint-cli2.yaml`'s `ignores` list instead of using a separate `.markdownlintignore` file to keep CI and scripts consistent.
For LAN/mobile testing, start a tunnel inside tmux with `devpod ssh myblog-devpod --start-services=false --forward-ports 0.0.0.0:4000:127.0.0.1:4000 --forward-ports 0.0.0.0:35730:127.0.0.1:35730 --forward-ports 0.0.0.0:5173:127.0.0.1:5173 --command 'sleep 1d'` so the port-forward persists even if your local terminal closes.

## Commit & Pull Request Guidelines
Recent history favors sentence-case commit messages with concise imperatives (e.g., `Initialize Jekyll…`). Keep subjects under ~72 characters and add detail in the body when needed. Pull requests should summarize the change, list affected pages, and note `bundle exec jekyll build` + html-proofer results. Include screenshots or GIFs for visual updates and reference issues with `Fixes #ID` so automation can close them on merge.
After changing Sass or front-end assets, run `pnpm run build` (or the appropriate bundler command) and restart the Jekyll dev server so the test server reflects the latest CSS/JS.
