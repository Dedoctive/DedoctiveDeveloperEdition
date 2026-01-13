#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

# Resolve script directory (works cross-platform)
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$EnvFile = Join-Path $Root ".env"

if (-not (Test-Path $EnvFile)) {
    Write-Error "Missing .env file at: $EnvFile"
}

# Load .env into environment
Get-Content $EnvFile | ForEach-Object {
    $line = $_.Trim()
    # Ignore comments and blank lines
    if (-not $line -or $line.StartsWith("#")) {
        return
    }
    if ($line -notmatch '^\s*([^=]+)\s*=\s*(.*)\s*$') {
        Write-Error "Invalid .env line: $line"
    }

    $key = $matches[1].Trim()
    $value = $matches[2].Trim()

    # Strip surrounding single or double quotes
    if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
        $value = $value.Substring(1, $value.Length - 2)
    }

    if (-not $key) {
        Write-Error "Invalid .env entry: empty key"
    }

    Set-Item -Path "Env:$key" -Value $value
}

# Validate required variables
$RequiredVars = @("ROOT_USER", "API_KEYS")
foreach ($var in $RequiredVars) {
    if (-not (Get-Item "Env:$var" -ErrorAction SilentlyContinue)) {
        Write-Error "Required environment variable '$var' is missing in .env"
    }
}

# Stop and remove container if exists
$ContainerName = "dedoctive-developer-edition"
$existing = docker ps -a --filter "name=^/$ContainerName$" --format "{{.ID}}"
if ($existing) {
    Write-Host "Stopping and removing existing container: $ContainerName"
    docker rm -f $ContainerName | Out-Null
}

# Run container
docker run `
  --env ROOT_USER="$($env:ROOT_USER)" `
  --env API_KEYS="$($env:API_KEYS)" `
  --env LOG_LEVEL=ERROR `
  --env DEDUCTION_PATH=/deduction `
  --env IGNORE_WARNINGS=true `
  --volume "./Workflows:/deduction" `
  -p 4000:4000 `
  -p 8000:8000 `
  --workdir /app `
  --name $ContainerName `
  -d `
  dedoctive/dedoctive-developer-edition:latest

$Url = "http://localhost:4000"
$Bold = "`e[1m"
$Underline = "`e[4m"
$Cyan = "`e[36m"
$Reset = "`e[0m"
Write-Host "Container '$ContainerName' is now running in detached mode."
Write-Host ""
Write-Host "Navigate to $Bold$Underline$Cyan$Url$Reset to view the Designer"
Write-Host "Stop the container with:"
Write-Host "  docker stop $ContainerName"
Write-Host "Restart the container with:"
Write-Host "  docker start $ContainerName"