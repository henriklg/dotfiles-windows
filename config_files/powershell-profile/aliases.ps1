# File: aliases.ps1
# Author: Henrik Gjestang
# Description: The file contains aliases for various commands.

# Miscellaneous Aliases
Set-Alias pd "Get-Location"
Set-Alias hy "history"
Set-Alias grep "findstr"
Set-Alias evac ".\.venv\Scripts\Activate.ps1"
Set-Alias evde "deactivate"

# Application Aliases
Set-Alias py "python"
# Uncomment or customize as needed
# Set-Alias juno "jupyter notebook"
# Set-Alias jula "jupyter lab"
# Set-Alias dbx "databricks"

function hist { Get-Content $history_path }
function reload { . $PROFILE }
function x { exit }

# Directories
# function xhome { Set-Location $ubuntu_home }
function home { Set-Location $windows_home }
# function xdoc { Set-Location ("$ubuntu_home\Documents") }
function doc { Set-Location ("$windows_home\Documents") }
# function xdown { Set-Location "$ubuntu_home\Downloads" }
function down { Set-Location "$windows_home\Downloads" }
# function xdev { Set-Location "$ubuntu_home\dev" }
function dev { Set-Location "$windows_home\dev" }

# Git Aliases
function gst { git status -sb }
function gdi { git diff @args }
function gpu { git push --follow-tags @args }
function gfe { git fetch @args }
function gpl { git pull @args }
function gch { git checkout @args }
function gco { git commit -m @args }
function gad { git add -- @args }
function grm { git rm @args }
function gmv { git mv @args }
function glo { git log @args }
function gtr { git log --graph --oneline --decorate @args }
