# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Repository overview
- Purpose: my_blog — “my blog site” (from README.md)
- Stack signal: Jekyll (Ruby) inferred from .gitignore entries: _site/, .jekyll-cache/, .jekyll-metadata, vendor/, .bundle/
- Current state: No Gemfile, _config.yml, or site content are committed yet. Commands below assume a typical Jekyll setup once those files exist.

Common commands
Note: Prefer Bundler when a Gemfile is present. If there is no Gemfile yet, you can use globally installed gems as a temporary measure.

Environment and dependencies
- With Gemfile (recommended):
  - Install gems: bundle install
- Without Gemfile (temporary):
  - Install: gem install bundler jekyll

Local development
- Serve with live reload (serves http://127.0.0.1:4000 by default):
  - With Gemfile: bundle exec jekyll serve --livereload
  - Without Gemfile: jekyll serve --livereload
- Serve including drafts (useful during writing):
  - bundle exec jekyll serve --livereload --drafts

Build, clean
- Build static site into _site/:
  - bundle exec jekyll build
- Clean generated artifacts (_site/, caches):
  - bundle exec jekyll clean

Linting and tests
- No linters or tests are configured in this repository. If you add them later, document their commands here (e.g., markdownlint, rubocop, or link checkers) and how to run a single test.

High-level architecture (Jekyll)
- Build model: Jekyll converts content (Markdown/HTML with YAML front matter) through Liquid templates into a static site in _site/.
- Core building blocks:
  - _config.yml: Site configuration (title, url, baseurl, plugins). Jekyll reads this at build/serve time.
  - Content sources:
    - _posts/: Dated posts named YYYY-MM-DD-title.md with front matter.
    - Pages: Top-level .md/.html files (e.g., index.md) or directories with index.md.
    - Collections: Additional content groups (e.g., _projects/), configured in _config.yml.
    - _data/: YAML/JSON/CSV data files available to templates.
  - Presentation:
    - _layouts/: Base templates applied via layout in front matter.
    - _includes/: Reusable partials included from layouts/pages.
    - assets/ or similar: Static assets (CSS/JS/images); often processed by external tooling if configured.
- Plugins and dependencies:
  - Declared in Gemfile and enabled under plugins: in _config.yml. Use Bundler to ensure reproducible builds.
- Output:
  - Generated site is written to _site/ (ignored by Git per .gitignore). Deploy from this folder or via your host’s Jekyll builder.

Repo notes
- .gitignore entries indicate a standard Jekyll/Bundler workflow; avoid committing _site/, caches, or vendor/.
- No CI/CD configuration or additional tool-specific rules were found.

If/when the Jekyll scaffolding (Gemfile, _config.yml, content) is added, the commands above should work as-is. If a different static-site stack is introduced, update this file accordingly.

