$ErrorActionPreference = "Stop"

function Wait-ForExit {
    param(
        [string]$Message
    )

    Write-Output ""
    Write-Host $Message -ForegroundColor Green

    try {
        [void][System.Console]::ReadKey($true)
    }
    catch {
        Read-Host | Out-Null
    }
}

function Write-Problem {
    param(
        [string]$Message
    )

    Write-Host "Problem detected: $Message" -ForegroundColor Red
}

try {
    if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
        Write-Problem "Ollama couldn't be found. Please install Ollama or add it to your PATH."
        Wait-ForExit "Please click any key to exit :)"
        return
    }

    $ollamaListOutput = ollama list

    if ($LASTEXITCODE -ne 0) {
        Write-Problem "Failed to get Ollama model list."
        Wait-ForExit "Please click any key to exit :)"
        return
    }

    $models = @(
        $ollamaListOutput |
            Select-Object -Skip 1 |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
            ForEach-Object { ($_ -split '\s+')[0] }
    )

    if (-not $models -or $models.Count -eq 0) {
        Write-Problem "No Ollama models found."
        Wait-ForExit "Please click any key to exit :)"
        return
    }

    foreach ($model in $models) {
        Write-Output "Updating model: $model"

        ollama pull $model

        if ($LASTEXITCODE -ne 0) {
            Write-Problem "Failed to update model: $model"
            Wait-ForExit "Please click any key to exit :)"
            return
        }

        Write-Output "--"
    }

    Wait-ForExit "Everything updated or already been updated. Please click any key to exit :)"
}
catch {
    Write-Problem "$($_.Exception.Message)"
    Wait-ForExit "Please click any key to exit :)"
}