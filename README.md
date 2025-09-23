# devkit-copilot — developer guide

This repository contains developer tooling examples for our team: VS Code workspace settings, conventional changelog and release helpers, Codacy integration, GitHub Copilot review prompts, and Yarn usage.

Keep this README short and practical — follow the sections below for quick onboarding.

## 1) VS Code: workspace `settings.json`
- Location: `.vscode/settings.json` in the repo — this is a workspace-level file and will apply for team members who open the folder.
- Purpose: ensure the integrated terminal matches your interactive shell and provide lightweight Copilot Chat review prompts.

Recommended settings (already added to `.vscode/settings.json`):

```json
{
  "github.copilot.chat.reviewSelection.instructions": [
    "Check quickly for OWASP Top 10 risks (injection, auth, access control)",
    "Flag secrets/hardcoded credentials and suggest minimal secure fixes"
  ],
  "terminal.integrated.profiles.osx": {
    "zsh (login)": {
      "path": "/bin/zsh",
      "args": ["-l"]
    }
  },
  "terminal.integrated.defaultProfile.osx": "zsh (login)"
}
```

Notes:
- The `zsh -l` profile makes the integrated terminal source `~/.zprofile` so Homebrew, nvm, and other PATH changes are available. If contributors prefer not to change VS Code, they can add `source ~/.zprofile` to their `~/.zshrc`.
- The Copilot Chat instructions are intentionally short and unobtrusive; they instruct Copilot to provide a quick security-focused review when using the `Review Selection` command.

## 2) conventional-changelog-cli scripts (changelog & release)
We use `conventional-changelog-cli` to generate the repository `CHANGELOG.md` and a small bash release helper to bump versions and tag releases.

Key scripts in `package.json`:
- `changelog` — runs conventional-changelog to update `CHANGELOG.md` from commit messages.
- `release` / `release:patch` / `release:minor` / `release:major` / `release:set` — wrappers that call `./scripts/release.sh`. The helper will:
  1. bump `package.json` (using `npm version --no-git-tag-version`),
  2. run conventional-changelog to update `CHANGELOG.md`,
  3. commit `package.json` and `CHANGELOG.md`, and
  4. create an annotated tag `vX.Y.Z`.

Workflow recommendations:
- Generate and preview `CHANGELOG.md` on your feature branch for reviewers:
  - `yarn run changelog` (or `npm run changelog`)
- Commit `CHANGELOG.md` if you want reviewers to see it, but do not run the full `release:*` script until the PR is merged into the release branch (usually `main`).
- When ready to publish a release on the release branch:
  - `yarn install` (or `npm install`)
  - `yarn run release:patch` (or appropriate bump)
  - `git push origin <branch>` and `git push --tags`

Important: conventional-changelog reads commit messages. To include PR numbers automatically, use squash/merge or make sure PR numbers are included in merge commits (GitHub does this by default). For enriched PR metadata (labels, descriptions), consider a GitHub-aware tool later (auto-changelog, release-please, or conventional-github-releaser).

## 3) Codacy (local checks and CI)
- This repo is configured to run Codacy analysis for edits. After editing files the project calls Codacy CLI analysis to surface issues.

Quick local checks (recommended):
- Run your linters and static checks before pushing. For example:
  - `npm run lint` (if configured)
  - `npx semgrep --config auto` (if Semgrep rules are used)
- Codacy in CI will run tools like Trivy and Semgrep. Fix issues the same way you fix linter errors: iterate locally, re-run analysis, and push a clean branch.

Note: In this repository environment the Codacy CLI may run extra checks (Trivy for SCA). If you add dependencies, CI will re-scan for vulnerabilities.

## 4) GitHub Copilot Chat (workspace review hints)
- The workspace settings include a short `reviewSelection.instructions` array. To use it:
  1. Select code in the editor.
  2. Run the command palette → `Copilot Chat: Review selection` (or use the Copilot Chat UI).
  3. Copilot Chat will use the workspace instructions to focus on security review and flag secrets.

Tips:
- Keep instructions short — they guide Copilot's review but do not replace a manual security review.
- Avoid embedding sensitive or private data in workspace settings (these settings are committed to the repo).

## 5) Yarn (project dependency management)
- This project uses Yarn (Classic) for installs. We recommend:
  - Use the same package manager and commit `yarn.lock` to the repo.
  - Install dependencies locally before running scripts: `yarn install`.
  - Run scripts with Yarn: `yarn run changelog`, `yarn run release:patch`.

If you prefer npm, the included `package.json` scripts are compatible with `npm run ...` as well. But do not mix lockfile formats in the repo — choose one (Yarn -> `yarn.lock`, npm -> `package-lock.json`).

## Quick reference: common commands
```bash
# install deps
yarn install

# preview changelog (updates CHANGELOG.md)
yarn run changelog

# run release helper (patch)
yarn run release:patch

# verify last commits and tags
git log --oneline -n 5
git tag --list --sort=-creatordate

# push after release
git push origin main
git push --tags
```

## Want automation?
- I can add a GitHub Actions workflow that runs Semgrep + Trivy on PRs, and another workflow that generates release notes and creates tags on merge to `main`. Tell me if you want those added.

---

If you'd like, I can also add a short `SECURITY.md` with the OWASP checklist and a PR template that includes a small security checklist for reviewers. Which would you prefer next?
# devkit-copilot

## VS Code integrated terminal setup

This project uses Node/Yarn tooling. To ensure the VS Code integrated terminal has the same environment as your interactive terminal (so `node`, `npm`, and `yarn` are available), configure the integrated terminal to run a login `zsh` shell.

1. Open workspace settings (Command Palette → `Preferences: Open Workspace Settings (JSON)`) or create `.vscode/settings.json`.

2. Add the following JSON to force a login zsh terminal:

```json
{
    "github.copilot.chat.reviewSelection.instructions": [
        "Check quickly for OWASP Top 10 risks (injection, auth, access control)",
        "Flag secrets/hardcoded credentials and suggest minimal secure fixes"
    ],

	"terminal.integrated.profiles.osx": {
		"zsh (login)": {
			"path": "/bin/zsh",
			"args": ["-l"]
		}
	},
	"terminal.integrated.defaultProfile.osx": "zsh (login)"
}
```

3. Save and open a new integrated terminal (Terminal → New Terminal).

4. Verify the environment inside the new terminal:

```bash
echo $SHELL
which node && node --version
which npm && npm --version
which yarn && yarn -v
```

If any of those binaries are missing, ensure your `~/.zprofile` contains your PATH updates (for example `eval "$(/opt/homebrew/bin/brew shellenv)"`) or that `nvm` initialization is included in your login profile.

If you prefer not to change VS Code settings, you can also add this to the top of your `~/.zshrc` so interactive shells source login profile variables:

```bash
if [ -f "${HOME}/.zprofile" ]; then
	source "${HOME}/.zprofile"
fi
```

Either approach will make your integrated terminal behave like your iTerm terminal and ensure the dev tools (Node, npm, Yarn) are available for running scripts.

## VS Code + GitHub (quick setup)

1. Sign in: Install the **GitHub Pull Requests and Issues** extension and sign in with your GitHub account (Command Palette → `GitHub: Sign in`).

2. Recommended extensions:
	- GitHub Pull Requests and Issues
	- GitLens — powerful git insights
	- GitHub Copilot & GitHub Copilot Chat (if your org uses Copilot)

3. Copilot Chat review helper (workspace): use the `Review Selection` command on selected code. We added lightweight review instructions to the workspace settings to prompt a short security-first review.

4. Create a PR quickly:
	- Create a branch: `git checkout -b feat/your-change`
	- Commit your changes and push: `git push -u origin feat/your-change`
	- Open the GitHub Pull Requests view in VS Code and create the PR from the pushed branch.

5. Running the changelog and release helper:
	- Install dependencies (if not already): `yarn install`
	- Preview changelog generation: `yarn run changelog`
	- Run the scripted release (patch): `yarn run release:patch`

Notes: follow the repository's `CHANGELOG.md` output and push tags if you want to publish the release. The release script will create a commit and an annotated tag locally; push with `git push --tags` when ready.
