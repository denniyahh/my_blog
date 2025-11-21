# Theme Rebuild Work Plan

## Active Branch
- `001-mobile-first-redesign`

## Near-Term Objectives
- [ ] Lock mobile-first design tokens (type scale, spacing, and reaffirmed palette) in `docs/theme-spec.md`.
- [ ] Rebuild homepage hero + navigation for <=360px viewports with 48px tap targets (User Story P1).
- [ ] Audit `_posts` layouts so headings, lists, media, and code blocks scale responsively (User Story P2).
- [ ] Implement progressive enhancement breakpoints (>=768px, >=1024px) to prove desktop parity (User Story P3).
- [ ] Automate validation loop: `bundle exec jekyll build --config _config.yml,_config.ci.yml`, htmlproofer, markdownlint, Lighthouse Mobile capture + evidence upload.
- [x] Produce `.specify/scripts/bash/build-mobile-preview.sh` so agents can run the preview + Lighthouse steps end-to-end.

## Backlog Ideas
- Snapshot existing Minima palette variables into `_data/theme.json` for reuse in Markdown/front matter.
- Evaluate utility-class helper (Tailwind vs. rolling a small token-based utilities partial).
- Plan dark mode toggle and color-scheme media query once mobile-first baseline ships.
- Add responsive image pipeline (e.g., `cwebp` + `sharp-cli`) to guarantee <=150KB hero assets.

## Notes
- Keep plan updated at the end of each work session.
- Refer to `docs/specs/001-mobile-first-redesign/spec.md` for acceptance criteria + documentation requirements.
- Refer to `docs/theme-spec.md` for detailed design decisions.
- Refer to `docs/specs/001-mobile-first-redesign/spec.md` for acceptance criteria + documentation requirements.
- For LAN/mobile QA, always spin up the tmux-based port forward (`devpod ssh myblog-devpod --start-services=false --forward-ports 0.0.0.0:4000:127.0.0.1:4000 --forward-ports 0.0.0.0:35730:127.0.0.1:35730 --forward-ports 0.0.0.0:5173:127.0.0.1:5173 --command 'sleep 1d'`).
