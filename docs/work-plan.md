# Theme Rebuild Work Plan

## Active Branch
- `theme/rebuild`

## Near-Term Objectives
- [ ] Extract core Minima layouts/includes into repo for customization.
- [ ] Define design tokens (color, typography, spacing) in `docs/theme-spec.md`.
- [ ] Stand up SCSS pipeline (`assets/css/theme.scss`) and basic layout shell.
- [ ] Set up Neovim tooling (Treesitter, LSPs, Codex bindings) for UI work.
- [ ] Establish build+lint scripts (`bin/dev`, `bin/test`) to streamline the loop.

## Backlog Ideas
- Create design tokens data file (`_data/theme.json`) for reuse.
- Investigate Tailwind vs. custom utility classes.
- Plan dark mode toggle and theme switcher.
- Add image optimization pipeline (responsive sources).

## Notes
- Keep plan updated at the end of each work session.
- Refer to `docs/theme-spec.md` for detailed design decisions.
