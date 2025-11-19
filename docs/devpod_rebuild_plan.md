Step-by-Step Plan for an AI-Optimized DevPod

1. Rebuild the devcontainer around the flake.

   - Base image: mcr.microsoft.com/devcontainers/base:debian (lightweight).
   - Add features: nix, direnv, gh.
   - Set "postCreateCommand": "direnv allow" and "remoteEnv": { "DIRENV_LOG_FORMAT": "" }.
   - Remove Ruby/Node features—they’re pulled from the flake.
   - Commit .devcontainer/devcontainer.json, then run devpod up --recreate myblog-devpod.

2. Drop automatic port forwarding.

   - Delete "forwardPorts" from .devcontainer/devcontainer.json.
   - Use a dedicated command for LAN testing: devpod ssh myblog-devpod --start-services=false --forward-ports 0.0.0.0:4000:127.0.0.1:4000 --forward-ports 0.0.0.0:35730:127.0.0.1:35730 --forward-ports 0.0.0.0:5173:127.0.0.1:5173 --command 'sleep infinity'. Document it in AGENTS.md.

3. Standardize shell orchestration.

   - Add a justfile (or mise tasks) with recipes:

     just bootstrap    # bundle install && pnpm install
     just dev          # concurrently run jekyll serve + pnpm dev
     just build        # pnpm build && bundle exec jekyll build
     just preview      # docs/.specify/.../build-mobile-preview.sh

   - Update AGENTS.md so Codex and humans call just build instead of ad‑hoc commands.

4. Install helper tools in the flake/devpod.

   - Extend flake.nix packages with python3, patch, just, git-cliff, jq.
   - Provide /usr/local/bin/apply_patch (a tiny wrapper around patch -p0) so AI editors work normally.

5. Auto-start direnv + devshell for every shell.

   - Inside the devpod’s .bash_profile, add:

     eval "$(direnv hook bash)"
     direnv allow >/dev/null 2>&1 || true

   - Ensure nix and direnv are installed via devcontainer features (step 1). This removes the “nix: command not found” spam Codex hits on
     host shells.

6. Consolidate JS package management.

   - Decide on pnpm (preferred). Remove package-lock.json and package.json scripts that reference npm. Update CI and docs to use pnpm
     exclusively.

7. Add AI-specific guardrails.

   - Create scripts/codex-env.sh that runs any command via devpod ssh … direnv exec .. Update AGENTS.md to tell Codex to run ./scripts/
     codex-env.sh "<cmd>" so command routing is consistent.
   - Provide a docs/ai-playbook.md with: repo layout, common tasks, testing strategy, command snippets.

8. Improve lint/test automation.

   - Add .pre-commit-config.yaml with markdownlint, htmlproofer, prettier (for JS), and run pre-commit install in postCreateCommand.
   - Hook GitHub Actions to run just build + just preview, so AI changes are validated automatically.

9. Document port usage & tunnels.

   - Clarify in README.md how to expose 4000/5173/35730, including the dedicated devpod ssh --forward-ports command and the build-mobile-preview script’s port 4001 switch.

10. Optional AI upgrades.

    - Evaluate maintaining the project in a Codespaces-compatible devcontainer (since GitHub’s Copilot Agents run there).
    - Alternatively, adopt cursor or continue config files stored in .cursor / .continue. Provide skeleton prompts so Codex or other
      agents share the same context.

    Implementing these steps will eliminate the port wars, align the container with your Nix devshell, give Codex deterministic commands, and
    reduce the friction you currently see (missing Nix, missing apply_patch, manual rebuilds). Once the environment is reproducible, swapping
    Codex for a newer agent (Cursor AI, Copilot Agents, or proprietary tools) becomes plug-and-play—the heavy lifting is done by the devpod
    itself.
