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
winget install Microsoft.PowerShell (msstore)
winget install Microsoft.WindowsTerminal (msstore)
winget install JanDeDobbeleer.OhMyPosh (msstore)
winget install Git.Git
winget install Microsoft.VisualStudioCode
winget install astral-sh.uv
winget install astral-sh.ruff
# docker, gsudo, notepad++, python, wsl?

# ______________
# Other installs
# ______________
# Nerd fonts (from fonts-dir in repo, or 'oh-my-posh font install meslo')
# Terminal-Icons (done automatically from profile.ps1, or manually with 'Install-Module - Name Terminal-Icons')
# Pyenv? (disable windows app aliases)
# Poetry? ('poetry config virtualenvs.in-project true' to store venv in project folder)


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

# NB: not tested!
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