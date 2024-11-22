# Dotfiles for Windows

Set up and configure environment for data science development. Sync config changes between different machines.

## Using Git and the bootstrap script

You can clone the repository wherever you want, I like to keep it in `~/dev/dotfiles-windows`. The bootstrapping script will pull in the latest version (of MS terminal config, Git config, PowerShell profile, and Oh-My-Posh theme/config) and copy the files to the correct folder.

```ps
git clone git@github.com:henriklg/dotfiles-windows.git; cd dotfiles-windows; .\bootstrap.ps1
```

To update, `cd` into your local `dotfiles` repository and then:

```ps
.\bootstrap.ps1
```

## install.ps1

Short description of what actions are executed (or should be, when finished) when running [install.ps1](/install.ps1):

- Install all tools and packages needed for Data Science development.
- Override (or set up symlink) config files related to respective tools.
- Enable the user to update all tools and packages by running `install.ps1 --update`.

### Install TODOS

- [ ] winget: add test to avoid overriding installing
- [ ] test install script
- [ ] symlink to gitignore (or bootstrap instead)
- [ ] add install_extended with wsl?
- [ ] add functionality for running upgrade-all
- [ ] disable windows app aliases for python

## bootstrap.ps1

Description of how to use [bootstrap.ps1](/bootstrap.ps1). Run after making updates to config files.

- Ask user for confirmation to make changes to local files.
- Fetch from main.
- Overwrite local config files with content from main.

### Bootstrap TODOS

- [ ] Get started

## Ideas and thoughts

- Automatically run bootstrap from Reload-Profile in PWSH Profile?
- Decide if best to symlink or overwrite config-files
- Include vscode settings-file, with symlink? (syncing through github-profile today)
- Run install.ps1 from bootstrap on first run?
- Structure repo so only bootstrap, install, and readme is in repo root directory.
