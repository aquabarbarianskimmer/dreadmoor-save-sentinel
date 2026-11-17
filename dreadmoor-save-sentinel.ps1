<#
.SYNOPSIS
    DREADMOOR Save Sentinel — Read-Only Windows Diagnostic Script
.DESCRIPTION
    Performs non-invasive, read-only local checks on Windows (Steam paths, folder layout,
    file timestamps/sizes, and system info). Does NOT modify, delete, or upload any files,
    and does NOT require administrator privileges or changes to Windows Defender.
.NOTES
    License: MIT
#>

$ErrorActionPreference = 'SilentlyContinue'

function Get-SteamLibraries {
    $libs = @()
    $regPath = 'HKCU:\Software\Valve\Steam'
    $steamPath = (Get-ItemProperty -Path $regPath -Name 'SteamPath').SteamPath
    if (-not $steamPath) {
        $steamPath = 'C:\Program Files (x86)\Steam'
    }
    $steamPath = $steamPath -replace '/', '\'
    if (Test-Path $steamPath) {
        $libs += $steamPath
        $vdf = Join-Path $steamPath 'steamapps\libraryfolders.vdf'
        if (Test-Path $vdf) {
            $content = Get-Content -Path $vdf -Raw
            $matches = [regex]::Matches($content, '"path"\s+"([^"]+)"')
            foreach ($m in $matches) {
                $p = $m.Groups[1].Value -replace '\\', '\'
                if ((Test-Path $p) -and ($libs -notcontains $p)) {
                    $libs += $p
                }
            }
        }
    }
    return $libs
}

function Find-SteamGameDir {
    param([string[]]$FolderNames)
    foreach ($lib in (Get-SteamLibraries)) {
        foreach ($name in $FolderNames) {
            $candidate = Join-Path $lib "steamapps\common\$name"
            if (Test-Path $candidate) {
                return $candidate
            }
        }
    }
    return $null
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " DREADMOOR Save Sentinel (Read-Only Check)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[Searching DREADMOOR Save Locations]" -ForegroundColor Yellow
$searchRoots = @(
    "$env:USERPROFILE\AppData\LocalLow",
    "$env:USERPROFILE\AppData\Local",
    "$env:USERPROFILE\Documents"
)

foreach ($lib in (Get-SteamLibraries)) {
    $ud = Join-Path $lib "userdata"
    if (Test-Path $ud) { $searchRoots += $ud }
}

$foundAny = $false
foreach ($root in $searchRoots) {
    if (-not (Test-Path $root)) { continue }
    $dirs = Get-ChildItem -Path $root -Directory -Recurse -Depth 3 | Where-Object {
        $_.Name -match 'DREADMOOR|3629430'
    }
    foreach ($d in $dirs) {
        $foundAny = $true
        Write-Host "  Folder  : $($d.FullName)" -ForegroundColor Green
        $files = Get-ChildItem -Path $d.FullName -File -Recurse
        if ($files) {
            foreach ($f in $files) {
                $kb = [math]::Round($f.Length / 1KB, 2)
                Write-Host ("    - {0,-35} | {1,8} KB | Modified: {2}" -f $f.Name, $kb, $f.LastWriteTime)
            }
        } else {
            Write-Host "    (No files inside directory)" -ForegroundColor DarkYellow
        }
    }
}

if (-not $foundAny) {
    Write-Host "  No DREADMOOR save directories were found in standard profile paths." -ForegroundColor DarkYellow
}

Write-Host ""
Write-Host "Diagnostic complete. No files were modified." -ForegroundColor Green
Read-Host "Press Enter to exit"
