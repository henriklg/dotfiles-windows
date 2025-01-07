# File: functions.ps1
# Author: Henrik Gjestang
# Description: The file contains functions for various commands.

function Initialize-OhMyPosh {
    $themePath = "~\dev\dotfiles-windows\config_files\oh-my-posh\pk10_custom_theme.omp.json"
    try {
        # Attempt to initialize Oh-My-Posh with the given theme
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    }
    catch {
        if ($_.Exception -and $_.Exception.Message -like "*not recognized*") {
            Write-Host "Oh-My-Posh is not installed. Attempting to install via winget..."
            try {
                winget install JanDeDobbeleer.OhMyPosh -s winget
                oh-my-posh init pwsh --config $themePath | Invoke-Expression
                Write-Host "Oh-My-Posh installed and initialized successfully with theme: $themePath"
            }
            catch {
                Write-Host "Failed to install or initialize Oh-My-Posh: $_"
            }
        } else {
            Write-Host "An error occurred while initializing Oh-My-Posh: $_"
        }
    }
}

function Initialize-WingetCompletion {
    Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }
}

function Initialize-UVCompletion {
    try {
        # Attempt to generate and register UV tab completion
        (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
    }
    catch {
        # If an exception occurs, check if the UV command is missing
        if ($_.Exception -and $_.Exception.Message -like "*not recognized*") {
            Write-Host "UV is not installed. Attempting to install UV via winget..."
            try {
                winget install astral-sh.uv -s winget
                (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
                Write-Host "UV installed and tab completion registered successfully."
            }
            catch {
                Write-Host "Failed to install or register UV: $_"
            }
        } else {
            Write-Host "An error occurred while registering UV tab completion: $_"
        }
    }
}
