param(
    [ValidateSet('all', 'report', 'thesis', 'notes')]
    [string]$Template = 'all'
)

$ErrorActionPreference = 'Stop'
if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    throw 'latexmk is required. Install a current TeX Live or MiKTeX distribution.'
}
if (-not (Get-Command lualatex -ErrorAction SilentlyContinue)) {
    throw 'LuaLaTeX is required by these mcidoc templates.'
}
$templateNames = if ($Template -eq 'all') { @('report', 'thesis', 'notes') } else { @($Template) }
if (($templateNames -contains 'report' -or $templateNames -contains 'thesis') -and
    -not (Get-Command biber -ErrorAction SilentlyContinue)) {
    throw 'Biber is required for the bibliography.'
}

foreach ($templateName in $templateNames) {
    Push-Location -LiteralPath (Join-Path $PSScriptRoot $templateName)
    try {
        & latexmk main.tex
        if ($LASTEXITCODE -ne 0) { throw "Build failed for $templateName." }
        Write-Host "Built $templateName/main.pdf"
    }
    finally { Pop-Location }
}
