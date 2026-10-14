param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [switch]$UseSaveAs
)

$ErrorActionPreference = 'Stop'
$word = $null
$document = $null

try {
    $resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
    $resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
    $outputFormat = if ([System.IO.Path]::GetExtension($resolvedOutput) -ieq '.xps') { 18 } else { 17 }
    $outputDirectory = [System.IO.Path]::GetDirectoryName($resolvedOutput)
    if (-not [System.IO.Directory]::Exists($outputDirectory)) {
        [System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
    }

    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $word.DisplayAlerts = 0
    $word.ScreenUpdating = $true
    $word.Options.Pagination = $true
    $word.Options.BackgroundSave = $false

    $document = $word.Documents.Open($resolvedInput, $false, $false)

    foreach ($toc in $document.TablesOfContents) {
        $toc.Update() | Out-Null
    }
    $document.Fields.Update() | Out-Null
    $document.Repaginate()
    $word.ScreenRefresh()
    Start-Sleep -Milliseconds 2000
    $document.Save()
    Start-Sleep -Milliseconds 1000

    if ($UseSaveAs) {
        $document.SaveAs2($resolvedOutput, $outputFormat)
    }
    else {
        $document.ExportAsFixedFormat($resolvedOutput, $outputFormat)
    }
    Start-Sleep -Milliseconds 2000
    Write-Output $resolvedOutput
}
finally {
    if ($null -ne $document) {
        $document.Close(0)
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($document)
    }
    if ($null -ne $word) {
        $word.Quit()
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($word)
    }
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}
