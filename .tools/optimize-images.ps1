Add-Type -AssemblyName System.Drawing

$ErrorActionPreference = "Stop"

function Save-Png {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [string]$Path
    )

    $dir = Split-Path $Path -Parent
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }

    $temp = [System.IO.Path]::Combine($dir, ([System.IO.Path]::GetRandomFileName() + ".png"))
    try {
        $Bitmap.Save($temp, [System.Drawing.Imaging.ImageFormat]::Png)
        Copy-Item -Path $temp -Destination $Path -Force
    }
    finally {
        if (Test-Path $temp) {
            Remove-Item $temp -Force -ErrorAction SilentlyContinue
        }
    }
}

function Resize-ImageFile {
    param(
        [string]$Path,
        [int]$MaxSize,
        [switch]$Square
    )

    $source = [System.Drawing.Image]::FromFile($Path)
    try {
        $width = $source.Width
        $height = $source.Height

        if ($Square) {
            $scale = [double]$MaxSize / [Math]::Max($width, $height)
        }
        else {
            $scale = [double]$MaxSize / [Math]::Max($width, $height)
            if ($scale -ge 1) {
                Write-Output "SKIP $Path ($width x $height already within $MaxSize)"
                return
            }
        }

        if ($scale -ge 1 -and -not $Square) {
            return
        }

        if ($scale -gt 1) { $scale = 1 }

        $targetWidth = [Math]::Max(1, [int][Math]::Round($width * $scale))
        $targetHeight = [Math]::Max(1, [int][Math]::Round($height * $scale))

        $bitmap = New-Object System.Drawing.Bitmap $targetWidth, $targetHeight, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        try {
            $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
            $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.Clear([System.Drawing.Color]::Transparent)
            $graphics.DrawImage($source, 0, 0, $targetWidth, $targetHeight)
        }
        finally {
            $graphics.Dispose()
        }

        $beforeKb = [Math]::Round((Get-Item $Path).Length / 1KB, 1)
    }
    finally {
        $source.Dispose()
    }

    try {
        Save-Png -Bitmap $bitmap -Path $Path
        $afterKb = [Math]::Round((Get-Item $Path).Length / 1KB, 1)
        Write-Output ("OK  {0}  {1}x{2} -> {3}x{4}  {5}KB -> {6}KB" -f (Split-Path $Path -Leaf), $width, $height, $targetWidth, $targetHeight, $beforeKb, $afterKb)
    }
    finally {
        $bitmap.Dispose()
    }
}

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$images = Join-Path $root "assets\images"

$jobs = @(
    @{ Path = Join-Path $images "hero-feature-biorezonanta-clear.png"; Max = 220; Square = $true },
    @{ Path = Join-Path $images "hero-feature-numerologie1.png"; Max = 220; Square = $true },
    @{ Path = Join-Path $images "hero-feature-medicina-holistica3.png"; Max = 220; Square = $true }
)

foreach ($job in $jobs) {
    if (-not (Test-Path $job.Path)) {
        Write-Warning "Missing $($job.Path)"
        continue
    }

    if ($job.Square) {
        Resize-ImageFile -Path $job.Path -MaxSize $job.Max -Square
    }
    else {
        Resize-ImageFile -Path $job.Path -MaxSize $job.Max
    }
}
