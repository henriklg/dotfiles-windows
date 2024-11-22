# ___
# Script for updating PS profile - pull from git, copy to correct directory
# and reload profile.

# Flow:
# - Ask user for confirmation
# - Grab origin main from repo
# - Copy to correct direcotries
# - Source profile etc
#   - add sourcing of pwsh profile in local profile.ps1 (look in top of powershell_profile.ps1) and run "reload"
#   - add symlink to terminal settings-file
#   - add symlink to gitconfig-file
#   - (maybe?) add symlink to vscode_usersettings-file
# ___



# _____________________________________________________
# Symlink Windows Terminal Settings to dotfiles-windows
# _____________________________________________________
Remove-Item -Path $Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force –Recurse
# need admin to symlink
New-Item -ItemType SymbolicLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "$HOME\dev\dotfiles-windows\terminal_setup"


# ______________________________________
# Point pwsh profile to dotfiles-windows
# ______________________________________
# NB: must be run from pwsh 7
# NB: first check if expression already in $PROFILE
Set-Content -Path $PROFILE -Value '". $HOME\dev\dotfiles-windows\powershell_profile.ps1" | Invoke-Expression'
