# Dotfiles for windows


### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/dev/dotfiles-windows`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to the correct folder.

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

### TODO
- Set up bootstrap script
  - Get user confirmation to override
  - Sync from github
  - Copy pwsh profile to directory
- Set up install script
  - chocolatey, MS terminal, Pyenv, poetry, git, fonts, pwsh, oh-my-posh
- ~~Add dotfiles, configs, themes and fonts~~