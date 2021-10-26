##############
# Oh-My-Posh #
##############
Import-Module oh-my-posh
Set-PoshPrompt -Theme powerlevel10k_rainbow
# Remove prompt in history
Enable-PoshTransientPrompt


#############
# Variables #
#############
$ubuntu_home = "Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu-20.04\home\henriklg\"
$windows_home = $Home+"\"
$onedrive = ($windows_home + "OneDrive\")


#########
# Alias #
#########
# Misc
Set-Alias pd "Get-Location"
Set-Alias hy "history"
function hist { Get-Content ($env:APPDATA+"\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt") }
function reload { . $profile }
function x { exit }

# Directories
function xhome { Set-Location $ubuntu_home }
function home { Set-Location $windows_home }
function xdoc { Set-Location ($ubuntu_home + "Documents\") }
function doc { Set-Location ($windows_home + "Documents\") }
function xdown { Set-Location ($ubuntu_home + "Downloads\") }
function down { Set-Location ($windows_home + "Downloads\") }
function xdev { Set-Location ($ubuntu_home + "dev\") }
function dev { Set-Location ($windows_home + "dev\") }

# Applications
Set-Alias py "python3"
Set-Alias juno "jupyter notebook"
Set-Alias jula "jupyter lab"

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