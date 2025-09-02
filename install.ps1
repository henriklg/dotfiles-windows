
# _____________________________________________________
# Script to set up and install/update dependencies for data science dev
# Usage: Run as administrator. Use --update to upgrade tools.
# _____________________________________________________

param(
    [switch]$Update
)

# Set execution policy (if not already set)
if ((Get-ExecutionPolicy) -ne 'AllSigned') {
    Set-ExecutionPolicy AllSigned -Scope Process -Force
}

# List of tools to install/update via winget
$wingetTools = @(
    @{ Id = 'Microsoft.PowerShell'; Source = 'msstore' },
    @{ Id = 'Microsoft.WindowsTerminal'; Source = 'msstore' },
    @{ Id = 'JanDeDobbeleer.OhMyPosh'; Source = 'msstore' },
    @{ Id = 'Git.Git'; Source = 'winget' },
    @{ Id = 'Microsoft.VisualStudioCode'; Source = 'winget' },
    @{ Id = 'astral-sh.uv'; Source = 'winget' },
    @{ Id = 'astral-sh.ruff'; Source = 'winget' }
    # Add more tools as needed
)

function Install-Or-Update-Tool {
    param(
        [string]$Id,
        [string]$Source
    )
    if ($Update) {
        Write-Host "Updating $Id..."
        winget upgrade --id $Id --source $Source --silent --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host "Installing $Id..."
        winget install $Id -s $Source --silent --accept-package-agreements --accept-source-agreements
    }
}

# Install or update all tools
foreach ($tool in $wingetTools) {
    Install-Or-Update-Tool -Id $tool.Id -Source $tool.Source
}

# Other installs
# Nerd fonts (from fonts-dir in repo, or 'oh-my-posh font install meslo')
# Terminal-Icons (done automatically from profile.ps1, or manually with 'Install-Module -Name Terminal-Icons')
# Pyenv? (disable windows app aliases)
# Poetry? ('poetry config virtualenvs.in-project true' to store venv in project folder)

# Python env setup
Write-Host "Installing pyenv-win..."
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"
&"./install-pyenv-win.ps1"


Write-Host "Installing Poetry..."
Invoke-WebRequest -Uri https://install.python-poetry.org -OutFile install-poetry.py
py install-poetry.py
#poetry config virtualenvs.in-project true

# Install fonts
Install-Fonts

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