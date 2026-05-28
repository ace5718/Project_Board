# Clone or update sub-projects listed in projects.list
# Usage: .\scripts\clone.ps1 [-ListPath projects.list]

param(
    [string]$ListPath = "projects.list"
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$listFile = Join-Path $root $ListPath

if (-not (Test-Path $listFile)) {
    Write-Error "List file not found: $listFile"
}

Write-Host "Reading $listFile ..." -ForegroundColor Cyan
Push-Location $root

try {
    Get-Content $listFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -eq "" -or $line.StartsWith("#")) { return }

        $parts = $line -split '\|' | ForEach-Object { $_.Trim() }
        if ($parts.Count -lt 3) {
            Write-Warning "Skipping invalid line (need name | path | url): $line"
            return
        }

        $name, $localPath, $gitUrl = $parts[0], $parts[1], $parts[2]
        $branch = if ($parts.Count -ge 4 -and $parts[3]) { $parts[3] } else { $null }
        $target = Join-Path $root $localPath

        if (Test-Path (Join-Path $target ".git")) {
            Write-Host "[update] $name -> $localPath" -ForegroundColor Yellow
            Push-Location $target
            git pull
            Pop-Location
            return
        }

        Write-Host "[clone]  $name -> $localPath" -ForegroundColor Green
        $parent = Split-Path -Parent $target
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }

        if ($branch) {
            git clone --branch $branch $gitUrl $target
        } else {
            git clone $gitUrl $target
        }
    }
}
finally {
    Pop-Location
}

Write-Host "Done." -ForegroundColor Cyan
