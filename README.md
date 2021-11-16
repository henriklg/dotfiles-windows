# Dotfiles for windows


### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/dev/dotfiles-windows`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version (of MS terminal config, Git config, PowerShell profile, and Oh-My-Posh theme/config) and copy the files to the correct folder.

```ps
git clone git@github.com:henriklg/dotfiles-windows.git; cd dotfiles-windows; .\bootstrap.ps1
```

To update, `cd` into your local `dotfiles` repository and then:

```ps
.\bootstrap.ps1
```

To update later on, just run that command again.

### Git-free install

To install these dotfiles without Git:

```ps
TODO
```

### install.ps1
Short description of what actions are executed (or should be, when finished) when running install.ps1:
- Run `Set-ExecutionPolicy AllSigned`
- Install [Git](https://git-scm.com/download/win) - Optional: [GitHub Desktop](https://desktop.github.com/)
- Install PowerShell 7.2 ([MS Store](https://www.microsoft.com/en-us/p/powershell/9mz1snwt0n5d?activetab=pivot:overviewtab))
- Install [Chocolatey](https://chocolatey.org/install) (NB: Admin)
- Install [Pyenv](https://github.com/pyenv-win/pyenv-win) (`choco install pyenv-win`, and disable app aliases, NB: Admin)
- Install [Poetry](https://python-poetry.org/docs/#windows-powershell-install-instructions) (`poetry config virtualenvs.in-project true`)
- (Optional) Install [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
- (Optional) Install [Oh-My-Posh](https://ohmyposh.dev/docs/pwsh) and [MesloLGS NF](https://github.com/henriklg/dotfiles-windows/tree/main/fonts) fonts


### TODO
- [ ] Set up bootstrap script
  - [ ] Get user confirmation to override
  - [ ] Sync from github
  - [ ] Copy pwsh profile to directory
- [ ] Set up install script
  - [ ] chocolatey, MS terminal, Pyenv, poetry, git, fonts, pwsh, oh-my-posh
- [x] ~~Add dotfiles, configs, themes and fonts~~
