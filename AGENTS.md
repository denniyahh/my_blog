# Repository Guidelines

## Project Structure & Module Organization
The site follows the GitHub Pages Jekyll layout. Source markdown lives at the root (`index.md` for the landing page, `about.md` for the profile), while long-form content belongs in `_posts/` using the `YYYY-MM-DD-slug.md` pattern. Global settings sit in `_config.yml` with CI overrides in `_config.ci.yml`. Automation resides under `.github/workflows/`, and formatter settings are tracked in `.editorconfig` and `.markdownlint-cli2.yaml`. Generated output in `_site/` is disposable—never edit it by hand.

## Build, Test, and Development Commands
- `bundle install` — install Ruby 3.2 dependencies defined in the `Gemfile`.
- `bundle exec jekyll serve --livereload` — run the site locally at `http://127.0.0.1:4000/` with hot reload.
- `bundle exec jekyll build --trace` — create a production build in `_site/` with verbose diagnostics.
- `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https` — validate internal links and markup after a build.

## Coding Style & Naming Conventions
Two-space indentation, LF endings, and trimmed whitespace are enforced via `.editorconfig`. Posts always start with YAML front matter declaring `title` and optional `description`. Stick to GitHub Flavored Markdown (set through kramdown) and keep heading levels consistent. Inline HTML is allowed for complex layouts; pair it with semantic classes from Minima when possible. Reference images from an `assets/` folder and use hyphenated filenames.

## Testing Guidelines
Mirror CI by running `bundle exec jekyll build --config _config.yml,_config.ci.yml` before checks. Follow up with the html-proofer command above to catch broken anchors or HTML regressions. Markdownlint (`npx markdownlint-cli2 "**/*.md"`) and Lychee link checks both run in GitHub Actions; resolve any warnings locally to keep pipelines green. For new features, add sample content or fixtures under `_posts/` to exercise the changes.

## Commit & Pull Request Guidelines
Recent history favors sentence-case commit messages with concise imperatives (e.g., `Initialize Jekyll…`). Keep subjects under ~72 characters and add detail in the body when needed. Pull requests should summarize the change, list affected pages, and note `bundle exec jekyll build` + html-proofer results. Include screenshots or GIFs for visual updates and reference issues with `Fixes #ID` so automation can close them on merge.
