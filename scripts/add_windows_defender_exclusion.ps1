# PowerShell Script to Add Windows Defender Exclusion for CAPER Suite
# This script must be run as Administrator

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Red
    Write-Host " ERROR: This script must be run as Administrator" -ForegroundColor Red
    Write-Host "================================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "To run as Administrator:" -ForegroundColor Yellow
    Write-Host "  1. Right-click on PowerShell" -ForegroundColor Yellow
    Write-Host "  2. Select 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host "  3. Navigate to this directory" -ForegroundColor Yellow
    Write-Host "  4. Run this script again" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " CAPER Suite - Windows Defender Exclusion Setup" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

# Get the current directory (where CAPER Suite is installed)
$caperPath = $PSScriptRoot

Write-Host "CAPER Suite location: $caperPath" -ForegroundColor White
Write-Host ""

# Ask for confirmation
Write-Host "This script will add a Windows Defender exclusion for:" -ForegroundColor Yellow
Write-Host "  $caperPath" -ForegroundColor White
Write-Host ""
Write-Host "This is necessary because Windows Defender flags the PASAT and other" -ForegroundColor Yellow
Write-Host "legacy VB6 executables as false positives." -ForegroundColor Yellow
Write-Host ""

$confirmation = Read-Host "Do you want to proceed? (Y/N)"

if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
    Write-Host ""
    Write-Host "Operation cancelled." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 0
}

Write-Host ""
Write-Host "Adding exclusion..." -ForegroundColor Cyan

try {
    # Add the exclusion path
    Add-MpPreference -ExclusionPath $caperPath

    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host " SUCCESS!" -ForegroundColor Green
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Windows Defender exclusion has been added for:" -ForegroundColor Green
    Write-Host "  $caperPath" -ForegroundColor White
    Write-Host ""
    Write-Host "All files in this directory (including subdirectories) are now" -ForegroundColor Green
    Write-Host "excluded from Windows Defender scanning." -ForegroundColor Green
    Write-Host ""

    # Verify the exclusion was added
    Write-Host "Verifying exclusion..." -ForegroundColor Cyan
    $exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath

    if ($exclusions -contains $caperPath) {
        Write-Host "✓ Exclusion verified successfully!" -ForegroundColor Green
    } else {
        Write-Host "⚠ Warning: Could not verify exclusion" -ForegroundColor Yellow
        Write-Host "  Please check Windows Security manually" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "You can now run the psychology tasks without interference." -ForegroundColor Green
    Write-Host ""
    Write-Host "To verify the exclusion:" -ForegroundColor Cyan
    Write-Host "  1. Open Windows Security" -ForegroundColor White
    Write-Host "  2. Go to Virus & threat protection" -ForegroundColor White
    Write-Host "  3. Click 'Manage settings'" -ForegroundColor White
    Write-Host "  4. Scroll to 'Exclusions'" -ForegroundColor White
    Write-Host "  5. You should see: $caperPath" -ForegroundColor White
    Write-Host ""

} catch {
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Red
    Write-Host " ERROR" -ForegroundColor Red
    Write-Host "================================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Failed to add exclusion: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please add the exclusion manually:" -ForegroundColor Yellow
    Write-Host "  1. Open Windows Security" -ForegroundColor White
    Write-Host "  2. Go to Virus & threat protection" -ForegroundColor White
    Write-Host "  3. Click 'Manage settings'" -ForegroundColor White
    Write-Host "  4. Scroll to 'Exclusions' and click 'Add or remove exclusions'" -ForegroundColor White
    Write-Host "  5. Click 'Add an exclusion' → 'Folder'" -ForegroundColor White
    Write-Host "  6. Select: $caperPath" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Read-Host "Press Enter to exit"
