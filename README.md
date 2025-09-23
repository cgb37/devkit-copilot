# devkit-copilot

## VS Code integrated terminal setup

This project uses Node/Yarn tooling. To ensure the VS Code integrated terminal has the same environment as your interactive terminal (so `node`, `npm`, and `yarn` are available), configure the integrated terminal to run a login `zsh` shell.

1. Open workspace settings (Command Palette → `Preferences: Open Workspace Settings (JSON)`) or create `.vscode/settings.json`.

2. Add the following JSON to force a login zsh terminal:

```json
{
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
