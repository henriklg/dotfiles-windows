
# Dotfiles for Windows

Automate setup and configuration for your data science development environment on Windows. Easily sync config changes between machines and keep your tools up to date.

## Quick Start

1. **Clone the repository**
	```ps
	git clone git@github.com:henriklg/dotfiles-windows.git
	cd dotfiles-windows
	```

2. **Install or update all tools and dependencies**
	```ps
	.\install.ps1           # Installs all required tools and configures your environment
	.\install.ps1 --update  # Upgrades all tools to the latest versions
	```

3. **Sync and activate your dotfiles**
	```ps
	.\bootstrap.ps1         # Pulls latest repo changes, sets up symlinks, reloads your PowerShell profile
	```

## install.ps1

This script installs and updates all tools and packages needed for data science development. It also sets up symlinks or copies config files to the correct locations.

**Features:**
- Installs PowerShell, Windows Terminal, Oh-My-Posh, Git, VSCode, UV, Ruff, and more via winget
- Installs Python environment tools (pyenv-win, Poetry)
- Installs fonts for terminal and editor use
- Use `--update` to upgrade all supported tools

## bootstrap.ps1

Run this script after making updates to your config files or to sync your setup on a new machine.

**Features:**
- Asks for confirmation before making changes
- Pulls the latest changes from the repo
- Sets up symlinks for Windows Terminal settings (and optionally VSCode, gitconfig)
- Ensures your PowerShell profile sources the repo profile
- Reloads your PowerShell session for changes to take effect

## Customization & Extensibility

- Add more tools to `install.ps1` as needed
- Uncomment symlink logic in `bootstrap.ps1` for VSCode and gitconfig
- Extend with WSL, Docker, or other tools for your workflow

## Ideas and thoughts

- Automatically run bootstrap from Reload-Profile in PWSH Profile?
- Decide if best to symlink or overwrite config-files
- Include VSCode settings-file, with symlink? (syncing through GitHub profile today)
- Run install.ps1 from bootstrap on first run?
