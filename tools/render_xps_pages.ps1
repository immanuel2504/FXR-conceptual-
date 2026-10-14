param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputDirectory,

    [int]$Dpi = 144
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName ReachFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputDirectory)
[System.IO.Directory]::CreateDirectory($resolvedOutput) | Out-Null

$xps = New-Object System.Windows.Xps.Packaging.XpsDocument(
    $resolvedInput,
    [System.IO.FileAccess]::Read
)
try {
    $sequence = $xps.GetFixedDocumentSequence()
    $paginator = $sequence.DocumentPaginator
    $paginator.ComputePageCount()
    $pageCount = $paginator.PageCount
}
finally {
    $xps.Close()
}

for ($index = 0; $index -lt $pageCount; $index++) {
    # Reopen for each page so WPF cannot reuse a stale glyph or visual cache.
    $pageXps = New-Object System.Windows.Xps.Packaging.XpsDocument(
        $resolvedInput,
        [System.IO.FileAccess]::Read
    )
    try {
        $pagePaginator = $pageXps.GetFixedDocumentSequence().DocumentPaginator
        $page = $pagePaginator.GetPage($index)
        $pixelWidth = [int][Math]::Round($page.Size.Width * $Dpi / 96.0)
        $pixelHeight = [int][Math]::Round($page.Size.Height * $Dpi / 96.0)

        $visual = New-Object System.Windows.Media.DrawingVisual
        $context = $visual.RenderOpen()
        $brush = New-Object System.Windows.Media.VisualBrush($page.Visual)
        $brush.Stretch = [System.Windows.Media.Stretch]::Fill
        $rect = New-Object System.Windows.Rect(0, 0, $pixelWidth, $pixelHeight)
        $context.DrawRectangle($brush, $null, $rect)
        $context.Close()

        $bitmap = New-Object System.Windows.Media.Imaging.RenderTargetBitmap(
            $pixelWidth,
            $pixelHeight,
            96,
            96,
            [System.Windows.Media.PixelFormats]::Pbgra32
        )
        $bitmap.Render($visual)

        $encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
        $encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($bitmap))
        $filename = 'page-{0:D3}.png' -f ($index + 1)
        $outputPath = Join-Path $resolvedOutput $filename
        $stream = [System.IO.File]::Open($outputPath, [System.IO.FileMode]::Create)
        try {
            $encoder.Save($stream)
        }
        finally {
            $stream.Dispose()
        }
    }
    finally {
        $pageXps.Close()
    }
}

Write-Output ("pages={0}" -f $pageCount)
