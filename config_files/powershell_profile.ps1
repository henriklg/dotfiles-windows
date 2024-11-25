# ADD THE FOLLOWING TO Microsoft.PowerShell_profile.ps1 file
# 
## Activate powershell profile from windows-dotfiles
# ". $HOME\dev\dotfiles-windows\config_files\powershell_profile.ps1" | Invoke-Expression

# slow load
# https://stackoverflow.com/questions/59341482/powershell-steps-to-fix-slow-startup

# Write-Host "Hi! 🌞🚀"

#############
# Variables #
#############
$windows_home = $HOME
# $ubuntu_home = ("$windows_home\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc\LocalState\rootfs\home\henriklg")
$onedrive = ("$windows_home\OneDrive")
$history_path = ("$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt")
# Remove venv prompt in shell (not compatible with oh-my-posh)
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

#########
# Alias #
#########
# Misc
Set-Alias pd "Get-Location"
Set-Alias hy "history"
Set-Alias grep "findstr"
Set-Alias evac ".\.venv\Scripts\Activate.ps1"
Set-Alias evde "deactivate"
# Applications
Set-Alias py "python"
# Set-Alias juno "jupyter notebook"
# Set-Alias jula "jupyter lab"
# Set-Alias dbx "databricks"

function hist { Get-Content $history_path }
# function reload { . $PROFILE }
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

# Git
function Get-GitStatus { & git status -sb $args }
New-Alias -Name gst -Value Get-GitStatus -Force -Option AllScope
function Get-GitDiff { & git diff $args }
New-Alias -Name gdi -Value Get-GitDiff -Force -Option AllScope
function Get-GitPush { & git push --follow-tags $args }
New-Alias -Name gpu -Value Get-GitPush -Force -Option AllScope
function Get-GitFetch { & git fetch $args }
New-Alias -Name gfe -Value Get-GitFetch -Force -Option AllScope
function Get-GitPull { & git pull $args }
New-Alias -Name gpl -Value Get-GitPull -Force -Option AllScope
function Get-GitCheckout { & git checkout $args }
New-Alias -Name gch -Value Get-GitCheckout -Force -Option AllScope
function Get-GitCommit { & git commit -m $args }
New-Alias -Name gco -Value Get-GitCommit -Force -Option AllScope
function Get-GitAdd { & git add -- $args }
New-Alias -Name gad -Value Get-GitAdd -Force -Option AllScope
function Get-GitRm { & git rm $args }
New-Alias -Name grm -Value Get-GitRm -Force -Option AllScope
function Get-GitMv { & git mv $args }
New-Alias -Name gmv -Value Get-GitMv -Force -Option AllScope
function Get-GitLog { & git log $args }
New-Alias -Name glo -Value Get-GitLog -Force -Option AllScope
function Get-GitTree { & git log --graph --oneline --decorate $args }
New-Alias -Name gtr -Value Get-GitTree -Force -Option AllScope
#function Get-GitCherryPick { & git cherry-pick $args }
#New-Alias -Name gcp -Value Get-GitCherryPick -Force -Option AllScope
#function Get-GitCommitEdit { & git commit -ev $args }
#New-Alias -Name gce -Value Get-GitCommitEdit -Force -Option AllScope
#function Get-GitCommitAmend { & git commit --amend $args }
#New-Alias -Name gca -Value Get-GitCommitAmend -Force -Option AllScope
#function Get-GitAddAll { & git add --all $args }
#New-Alias -Name gaa -Value Get-GitAddAll -Force -Option AllScope
#function Get-GitCheckoutBranch { & git checkout -b $args }
#New-Alias -Name gchb -Value Get-GitCheckoutBranch -Force -Option AllScope
#function Get-GitBranch { & git branch $args }
#New-Alias -Name gb -Value Get-GitBranch -Force -Option AllScope
#function Get-GitRemoteView { & git remote -v $args }
#New-Alias -Name grv -Value Get-GitRemoteView -Force -Option AllScope
#function Get-GitRemoteAdd { & git remote add $args }
#New-Alias -Name gra -Value Get-GitRemoteAdd -Force -Option AllScope


#######################
# Scripts / functions #
#######################
# Climb/Up function
for($i = 1; $i -le 5; $i++){
  $u =  "".PadLeft($i,"u")
  $unum =  "u$i"
  $d =  $u.Replace("u","../")
  Invoke-Expression "function $u { push-location $d }"
  Invoke-Expression "function $unum { push-location $d }"
}

# Initiate Oh-My-Posh and load theme
try {
  oh-my-posh init pwsh --config ~\dev\dotfiles-windows\config_files\oh-my-posh\pk10_custom_theme.omp.json | Invoke-Expression
}
catch [System.SystemException] {
  Write-Host $_
  Write-Host "Oh-my-posh not installed. Lets try to install it.."
  winget install JanDeDobbeleer.OhMyPosh -s winget
  oh-my-posh init pwsh --config ~\dev\dotfiles-windows\oh-my-posh\pk10_custom_theme.omp.json | Invoke-Expression
}

# Icons for files and folders
try {
  Import-Module -Name Terminal-Icons
}
catch {
  Write-Host $_
  Write-Host "Terminal-Icons not installed. Lets try to install it.."
  Install-Module -Name Terminal-Icons -Repository PSGallery
  Import-Module -Name Terminal-Icons
}

# Tab-completions in UV
try {
  (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
}
catch {
  Write-Host "UV not installed."
  #winget install astral-sh.uv
}

# Tab completions in Winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
      [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
      $Local:word = $wordToComplete.Replace('"', '""')
      $Local:ast = $commandAst.ToString().Replace('"', '""')
      winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
          [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
      }
}

# Reload PWSH profile the correct way
function reload {
  @(
      $Profile.AllUsersAllHosts,
      $Profile.AllUsersCurrentHost,
      $Profile.CurrentUserAllHosts,
      $Profile.CurrentUserCurrentHost
  ) | ForEach-Object {
      if(Test-Path $_){
          Write-Verbose "Running $_"
          . $_
      }
  }
}