<!--
Sync Impact Report
Version change: 1.1.0 → 1.2.0
Modified principles:
- VI. AI-agent-first workflow (new)
Added sections:
- None
Removed sections:
- None
Templates requiring updates:
- ✅ docs/myblog/.specify/templates/plan-template.md (new Principle VI gate)
- ✅ docs/myblog/.specify/templates/spec-template.md (checklist row for AI-agent workflow)
- ✅ docs/myblog/.specify/templates/tasks-template.md (tasks for remote AI execution + staging/production deploys)
Follow-up TODOs:
- None
-->

# my_blog Constitution

## Core Principles

### I. Markdown canon drives the site

- Landing-page content lives in `index.md`, profile details in `about.md`, and long-form writing in `_posts/YYYY-MM-DD-slug.md` or curated `longform.md` entries.
- Every Markdown file starts with YAML front matter declaring `title` (and optional `description`); filenames use kebab-case and descriptive slugs.
- `_site/` stays disposable Jekyll output—never edit, commit, or patch artifacts under it by hand.
  _Why_: Consistent content placement keeps GitHub Pages builds deterministic and makes editorial work predictable.

### II. Dual-runtime parity

- Install Ruby dependencies with `bundle install` and run all Ruby tooling through Bundler (`bundle exec jekyll serve`, `bundle exec jekyll build --config _config.yml,_config.ci.yml`, `bundle exec htmlproofer …`).
- Install Node tooling with `pnpm install`; use `pnpm dev` during local work and `pnpm run build` before production exports.
- Keep `_config.yml` and `_config.ci.yml` in sync, retain binstubs in `bin/`, and avoid ad-hoc environment tweaks that cannot be reproduced via `nix develop` or documented scripts.
  _Why_: Mirroring the Ruby and Node runtimes prevents “works-on-my-machine” drift between laptops, dev containers, and CI.

### III. Mobile-first single-hand experience

- Treat mobile (360–428 px viewports) as the source of truth in `docs/theme-spec.md`: define thumb-reachable grids, gesture targets ≥48 px, and single-column reading flows before considering tablet/desktop.
- Every visual or interaction change must include mobile screenshots/video plus Lighthouse Mobile + WebPageTest-style metrics: Largest Contentful Paint ≤2 s, input delay ≤100 ms, and interaction-ready payloads under 150 KB.
- Navigation, typography, and controls must be operable with one thumb; prefer bottom-aligned actions, sparse chrome, and animation budgets that never block scroll or taps.
  _Why_: The site’s audience primarily reads on phones; designing for one-handed comfort delivers a slick, minimalist, fast, and bug-free experience everywhere else “for free.”

### IV. CI-grade verification precedes every merge

- Before requesting review, run `bundle exec jekyll build --config _config.yml,_config.ci.yml` followed by `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`.
- Lint markdown via `npx markdownlint-cli2 "**/*.md"` and run any workflow-specific scripts defined in `.github/workflows/`.
- Pull requests document command outputs, list affected pages, and call out mitigations for intentional exceptions.
  _Why_: Local verification keeps GitHub Pages deployments evergreen and prevents broken navigation, anchors, or markup.

### V. Living documentation & plan discipline

- Update `docs/work-plan.md` at the end of each session with branch status and next steps.
- Keep `docs/theme-spec.md` and `docs/dev-environment-inventory.md` synchronized with the actual design system, toolchain, and open questions.
- Record visual or structural decisions (screenshots, gifs, rationale) in specs before landing code; link them in PRs.
  _Why_: Fresh documentation maintains clarity for a solo maintainer and speeds future context refreshes.

### VI. AI-agent-first workflow

- Every phase (planning, implementation, testing, staging, production deploy) must be executable end-to-end by an AI agent acting on scripted commands, with status and artifacts consumable from a smartphone.
- Tooling, vendors, and infra must expose CLI or API hooks so agents can provision branches, run tests, push to staging, collect screenshots/videos, and perform production releases immediately after the maintainer approves via chat.
- Maintain automated staging and production pipelines (e.g., GitHub Actions, CLI deploy scripts) that agents can run on demand, posting short preview URLs, logs, and screen recordings for thumb-friendly review; document fallback commands in `.specify/scripts`.
  _Why_: Remote, phone-based oversight demands delegated execution—agents handle keyboards; humans give intent, review output, request fixes, and green-light production.

## Platform Constraints & Content Rules

- GitHub Pages-compatible Jekyll plugins only; if a plugin is unsupported, document the blocker and choose an allow-listed alternative.
- Theme overrides live under `_layouts/`, `_includes/`, `_sass/`, and `assets/`; delete generated bundles in `assets/dist/` before committing.
- Assets (images, fonts, media) live in `assets/` with hyphenated filenames and descriptive alt text.
- Local dev servers must bind to `0.0.0.0` and respect forwarded ports 4000 (Jekyll) and 35730 (livereload) for remote previews.
- Never bypass `bundle exec` or `pnpm` scripts; reproducibility beats speed in this repo.
- Prefer automation-friendly services (GitHub Actions, Pages previews, CLI-first hosting) so AI agents can run workflows unattended and surface logs/links via chat for smartphone review; if a tool lacks remote control, document and maintain a shim that restores agent operability.

## Workflow & Review Process

1. Capture intent in `/specs/.../spec.md` and `/docs/...` artifacts before coding; include Constitution principle references in the “Constitution Check” section of each plan.
2. Break work into independently testable slices (`/speckit.plan`, `/speckit.tasks`) so each user story can be demoed and rolled back in isolation.
3. Implement via feature branches (e.g., `theme/rebuild` derivatives), keeping commits small, descriptive, and tied to checklist items.
4. Reviews verify: documentation updated, build + htmlproofer + lint logs attached, accessibility considerations addressed, and screenshots/GIFs provided for visual tweaks.
5. Staging and production deployments must be produced automatically (CI workflow or scripted CLI) so AI agents can post preview links, logs, and screenshots/video for smartphone review; production deploys run only after explicit user approval and agents must be able to re-run fixes + redeploy loops from the same chat.

## Governance

- This constitution supersedes other guidelines when conflicts arise; defer to README/AGENTS only when the constitution is silent.
- Amendments require: (a) an issue or PR summary describing the motivation, (b) updated supporting docs/templates, and (c) recorded build + htmlproofer results showing no regressions.
- **Versioning**: MAJOR for principle additions/removals or governance rewrites, MINOR for new requirements or sections, PATCH for clarifications that do not change obligations.
- Compliance reviews happen on every PR; reviewers block merges if any principle lacks explicit evidence (commands run, doc links, or rationale).

**Version**: 1.2.0 | **Ratified**: 2025-11-06 | **Last Amended**: 2025-11-06
