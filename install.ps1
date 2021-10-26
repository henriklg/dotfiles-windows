# ___
# Script to set up and install dependencies like pyenv, poetry, MS terminal, powershell 8,
# Oh-my-posh, chocolatey, powerlevel with themes etc.

# NB: Script must be run as a administrative shell
# ___

# to run script, set execution policy with PS-admin:
Set-ExecutionPolicy AllSigned

# ___
# Git
# ___
# (gp HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "git"


# ____________
# Install PS 7
# ____________
# Check if already installed
# NB: only checks if installed with windows store
Import-Module Appx -usewindowspowershell
$software = "Powershell_7"
$installed = Get-AppxPackage -AllUsers | Select PackageFullName | Select-String -Pattern $software -quiet
If(-Not $installed) {
	Write-Host "'$software' is NOT installed.";
} else {
    # Install
    msiexec.exe /package PowerShell-7.1.5-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
}


# __________________
# Install chocolatey
# __________________
try {
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) {
        Import-Module "$ChocolateyProfile" -ErrorAction Stop
    }
}
catch {
    Write-Host "Not installed - installing.."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}


# __________________
# Install oh-my-posh
# __________________
# Set fonts
Install-Fonts
# install oh-my-posh
choco install oh-my-posh
# Move theme
Copy-Item -Path ".pl10k_custom_theme.json" -Destination "C:\Users\henrik.gjestang\OneDrive - Itera\Documents\PowerShell\Modules\oh-my-posh\5.7.0\themes"



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

function Check-Installed($software) {
    $version = Invoke-Expression $"($software --version)"

    If($?) {
        Write-Host "'$software' version '$version' is installed.";
    } else {
        Write-Host "'$software' is Not installed."
    }
}