param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

function Ensure-PortableNode {
    param([string]$ToolsRoot)

    $nodeExe = Join-Path $ToolsRoot "node\node.exe"
    if (Test-Path $nodeExe) {
        return $nodeExe
    }

    Write-Host "Downloading portable Node.js v22.16.0..."
    $nodeDir = Join-Path $ToolsRoot "node"
    $zip = Join-Path $ToolsRoot "node.zip"
    New-Item -ItemType Directory -Force -Path $nodeDir | Out-Null
    Invoke-WebRequest -Uri "https://nodejs.org/dist/v22.16.0/node-v22.16.0-win-x64.zip" -OutFile $zip
    Expand-Archive -Path $zip -DestinationPath $ToolsRoot -Force
    Copy-Item -Path (Join-Path $ToolsRoot "node-v22.16.0-win-x64\*") -Destination $nodeDir -Recurse -Force
    Remove-Item (Join-Path $ToolsRoot "node-v22.16.0-win-x64") -Recurse -Force -ErrorAction SilentlyContinue

    if (-not (Test-Path $nodeExe)) {
        throw "Failed to install portable Node.js to $nodeDir"
    }

    return $nodeExe
}

function Ensure-PortableHugo {
    param([string]$ToolsRoot)

    $hugoExe = Join-Path $ToolsRoot "hugo-148\hugo.exe"
    if (Test-Path $hugoExe) {
        return $hugoExe
    }

    Write-Host "Downloading Hugo Extended v0.148.2..."
    $hugoDir = Join-Path $ToolsRoot "hugo-148"
    $zip = Join-Path $ToolsRoot "hugo-148.zip"
    New-Item -ItemType Directory -Force -Path $hugoDir | Out-Null
    Invoke-WebRequest -Uri "https://github.com/gohugoio/hugo/releases/download/v0.148.2/hugo_extended_0.148.2_windows-amd64.zip" -OutFile $zip
    Expand-Archive -Path $zip -DestinationPath $hugoDir -Force

    if (-not (Test-Path $hugoExe)) {
        throw "Failed to install Hugo Extended to $hugoDir"
    }

    return $hugoExe
}

$toolsRoot = Join-Path $Root ".tools"
New-Item -ItemType Directory -Force -Path $toolsRoot | Out-Null

$nodeExe = Ensure-PortableNode -ToolsRoot $toolsRoot
$hugoExe = Ensure-PortableHugo -ToolsRoot $toolsRoot

$nodeDir = Split-Path $nodeExe -Parent
$env:PATH = "$nodeDir;$Root\node_modules\.bin;$env:PATH"

Set-Location $Root

if (-not (Test-Path (Join-Path $Root "node_modules"))) {
    Write-Host "Installing npm dependencies..."
    & (Join-Path $nodeDir "npm.cmd") install
}

return @{
    Root = $Root
    NodeExe = $nodeExe
    HugoExe = $hugoExe
}
