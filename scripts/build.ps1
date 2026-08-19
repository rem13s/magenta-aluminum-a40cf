param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$HugoArgs
)

$ErrorActionPreference = "Stop"

$tools = & (Join-Path $PSScriptRoot "Ensure-DevTools.ps1")
$hugoExe = $tools.HugoExe

if ($HugoArgs.Count -eq 0) {
    $HugoArgs = @("--gc", "--minify")
}

Write-Host "Using Hugo: $hugoExe"
Write-Host "Using Node: $($tools.NodeExe)"

& $hugoExe @HugoArgs
