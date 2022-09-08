# _____________________________________________________
# Script to set up and install dependencies like pyenv,
# poetry, terminal, powershell 7, Oh-my-posh

# NB: Script must be run as a administrative shell
# _____________________________________________________

# to run script, set execution policy with PS-admin:
Set-ExecutionPolicy AllSigned


# ______________
# Winget install
# ______________
winget install Microsoft.PowerShell
winget install Microsoft.WindowsTerminal
winget install JanDeDobbeleer.OhMyPosh
winget install Git.Git
winget install Lexikos.AutoHotkey
winget install Docker.DockerDesktop
winget install Microsoft.VisualStudioCode
# notepad++
# python?


# _____________________________________________________
# Symlink Windows Terminal Settings to dotfiles-windows
# _____________________________________________________
Remove-Item -Path $Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force –Recurse
New-Item -ItemType SymbolicLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "$HOME\dev\dotfiles-windows\terminal_setup"


# ______________________________________
# Point pwsh profile to dotfiles-windows
# ______________________________________
# NB: must be run from pwsh 7
Set-Content -Path $PROFILE -Value '". $HOME\dev\dotfiles-windows\powershell_profile.ps1" | Invoke-Expression'


# __________
# Python env
# __________
# Pyenv
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"

# Poetry - NB: needs python installed
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
#poetry config virtualenvs.in-project true


# _____________
# Install fonts
# _____________
Install-Fonts


# _________
# Functions
# _________
function Install-Fonts {
    $FONTS = 0x14
    $Path = ".\fonts"
    $objShell = New-Object -ComObject Shell.Application
    $objFolder = $objShell.Namespace($FONTS)
    $Fontdir = dir $Path
    foreach($File in $Fontdir) {
        if(!($file.name -match "pfb$")) {
            $try = $true
            $installedFonts = @(Get-ChildItem c:\windows\fonts | Where-Object {$_.PSIsContainer -eq $false} | Select-Object basename)
            $name = $File.baseName

            foreach($font in $installedFonts) {
                $font = $font -replace "_", ""
                $name = $name -replace "_", ""
                if($font -match $name) {
                    $try = $false
                }
            }
            if($try) {
                $objFolder.CopyHere($File.fullname)
            }
        }
    }
}