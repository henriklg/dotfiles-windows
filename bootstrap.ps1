# Script for updating PS profile - pull from git, copy/symlink to correct directory, and reload profile.

function Confirm-Action {
    param([string]$Message)
    $response = Read-Host "$Message (y/n)"
    return $response -eq 'y'
}

if (-not (Confirm-Action "This will update your local config files. Continue?")) {
    Write-Host "Aborted by user."
    exit
}

# Pull latest from origin main
Write-Host "Pulling latest changes from origin/main..."
git pull origin main

# Symlink Windows Terminal Settings to dotfiles-windows
$terminalSettings = "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path $terminalSettings) {
    Remove-Item -Path $terminalSettings -Force -Recurse
}
New-Item -ItemType SymbolicLink -Path $terminalSettings -Target "$HOME\dev\dotfiles-windows\terminal_setup"

# Example: Symlink VSCode settings (uncomment if needed)
# $vscodeSettings = "$Env:APPDATA\Code\User\settings.json"
# if (Test-Path $vscodeSettings) { Remove-Item $vscodeSettings -Force }
# New-Item -ItemType SymbolicLink -Path $vscodeSettings -Target "$HOME\dev\dotfiles-windows\config_files\vscode_usersettings.json"

# Example: Symlink gitconfig (uncomment if needed)
# $gitConfig = "$HOME\.gitconfig"
# if (Test-Path $gitConfig) { Remove-Item $gitConfig -Force }
# New-Item -ItemType SymbolicLink -Path $gitConfig -Target "$HOME\dev\dotfiles-windows\config_files\gitconfig"

# Point pwsh profile to dotfiles-windows
$profileSource = ". $HOME\dev\dotfiles-windows\config_files\powershell-profile\profile.ps1"
if (-not (Get-Content $PROFILE | Select-String $profileSource)) {
    Add-Content -Path $PROFILE -Value $profileSource
    Write-Host "Added sourcing of dotfiles profile to $PROFILE"
} else {
    Write-Host "Dotfiles profile already sourced in $PROFILE"
}

# Reload profile
Write-Host "Reloading PowerShell profile..."
. $PROFILE