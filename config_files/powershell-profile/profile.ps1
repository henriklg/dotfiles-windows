# File: profile.ps1
# Author: Henrik Gjestang
# Description: Main profile file for powershell

# ADD THE FOLLOWING TO Microsoft.PowerShell_profile.ps1 file:
# Activate powershell profile from windows-dotfiles
# . "$HOME\dev\dotfiles-windows\config_files\powershell-profile\profile.ps1"

# Variables
$windows_home = $HOME
$onedrive = ("$windows_home\OneDrive")
$history_path = ("$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt")
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# Load components
. $HOME\dev\dotfiles-windows\config_files\powershell-profile\aliases.ps1
. $HOME\dev\dotfiles-windows\config_files\powershell-profile\functions.ps1

# Load modules and scripts
Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
Initialize-OhMyPosh
# Initialize-WingetCompletion
# Initialize-UVCompletion

## Climb/Up function
for($i = 1; $i -le 3; $i++){
    $u =  "".PadLeft($i,"u")
    $unum =  "u$i"
    $d =  $u.Replace("u","../")
    Invoke-Expression "function $u { push-location $d }"
    Invoke-Expression "function $unum { push-location $d }"
  }