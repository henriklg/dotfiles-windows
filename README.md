# Dotfiles for windows


## Using Git and the bootstrap script

You can clone the repository wherever you want, I like to keep it in `~/dev/dotfiles-windows`. The bootstrapper script will pull in the latest version (of MS terminal config, Git config, PowerShell profile, and Oh-My-Posh theme/config) and copy the files to the correct folder.

```ps
git clone git@github.com:henriklg/dotfiles-windows.git; cd dotfiles-windows; .\bootstrap.ps1
```

To update, `cd` into your local `dotfiles` repository and then:

```ps
.\bootstrap.ps1
```

To update later on, just run that command again.

## Git-free install

To install these dotfiles without Git:

```ps
TODO
```

# install.ps1 (script not yet finished)
Short description of what actions are executed (or should be, when finished) when running install.ps1:

Optional (but highly recommended):
- Install [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab): `winget install Microsoft.WindowsTerminal`
- Install [Oh-My-Posh](https://github.com/jandedobbeleer/oh-my-posh): `winget install JanDeDobbeleer.OhMyPosh -s winget` and [MesloLGS NF](https://github.com/henriklg/dotfiles-windows/tree/main/fonts) fonts (`oh-my-posh font install` as admin).
- Install VS code (`winget install Microsoft.VisualStudioCode`) and sign in with GitHub account for automatically setup of config files
- Install gsudo: `winget install gerardog.gsudo`
- `Set-ExecutionPolicy Bypass -Scope Process -Force` Maybe?


<details close>
<summary>
Install PowerShell 7
</summary>

- pwsh: `winget install PowerShell`
- [Microsoft docs](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.2)
- [github.com/PowerShell](https://github.com/PowerShell/PowerShell/releases)
</details>


<details close>
<summary>
Install Git
</summary>

- pwsh: `winget install --id Git.Git -e --source winget`
- Site: [Git](https://git-scm.com/download/win)
- Optional: [GitHub Desktop](https://desktop.github.com/)
- NB: remember to set `.gitconfig`
</details>


<details close>
<summary>
Install Pyenv
</summary>

- pwsh:
```ps
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
```
- [Pyenv repo](https://github.com/pyenv-win/pyenv-win)
- Disable windows app aliases
- Install Python 3.9.0: `pyenv install 3.9.0`
</details>


<details close>
<summary>
Install Poetry
</summary>

- [Poetry website](https://python-poetry.org/docs/#windows-powershell-install-instructions)
- [Poetry GitHub](https://github.com/python-poetry/poetry)
- Run the following in PowerShell (admin not needed):
```ps
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
```
- Run: `poetry config virtualenvs.in-project true` to store environments files in project folder
- Update (NB: Admin required): `poetry self update` (add '--preview' for latest preview)
</details>


***

## TODO
- [ ] Set up bootstrap script
  - [ ] Get user confirmation to override
  - [ ] Sync from github
  - [ ] add bootstrap to pwsh reload func
  - [ ] decide if best to symlink or push configs
- [ ] Set up install script
  - [ ] winget: add test to avoid overriding installing
  - [ ] test install script
  - [ ] symlink to gitignore (or bootstrap instead)
  - [ ] add install_extended with wsl?
  - [ ] disable windows app aliases for python
- [ ] add script for de-bloating windows
- [ ] update readme
- [x] ~~Add dotfiles, configs, themes and fonts to repository~~
