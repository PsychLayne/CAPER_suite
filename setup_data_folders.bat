@echo off
REM CAPER Suite - Data Collection Folder Setup
REM This script creates the necessary folders on C: drive for data collection

echo ========================================
echo CAPER Suite - Data Collection Setup
echo ========================================
echo.

REM Create main data collection directory
echo Creating main data directory...
if not exist "C:\CAPER_Data" (
    mkdir "C:\CAPER_Data"
    echo Created C:\CAPER_Data
) else (
    echo C:\CAPER_Data already exists
)

REM Create subdirectories for each task
echo.
echo Creating task subdirectories...

mkdir "C:\CAPER_Data\PASAT" 2>nul
mkdir "C:\CAPER_Data\PASAT_7550" 2>nul
mkdir "C:\CAPER_Data\BART_Auto" 2>nul
mkdir "C:\CAPER_Data\BART_Adol" 2>nul
mkdir "C:\CAPER_Data\BART_Options" 2>nul
mkdir "C:\CAPER_Data\BART_Options_P" 2>nul
mkdir "C:\CAPER_Data\BART_BAIT" 2>nul
mkdir "C:\CAPER_Data\Mirror_Task" 2>nul
mkdir "C:\CAPER_Data\BIRD_Basic" 2>nul

REM Create backup directory
mkdir "C:\CAPER_Data\Backups" 2>nul

REM Create exports directory
mkdir "C:\CAPER_Data\Exports" 2>nul

echo.
echo Task directories created:
echo   - C:\CAPER_Data\PASAT
echo   - C:\CAPER_Data\PASAT_7550
echo   - C:\CAPER_Data\BART_Auto
echo   - C:\CAPER_Data\BART_Adol
echo   - C:\CAPER_Data\BART_Options
echo   - C:\CAPER_Data\BART_Options_P
echo   - C:\CAPER_Data\BART_BAIT
echo   - C:\CAPER_Data\Mirror_Task
echo   - C:\CAPER_Data\BIRD_Basic
echo   - C:\CAPER_Data\Backups
echo   - C:\CAPER_Data\Exports

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo All data collection folders have been created.
echo Data will be stored in: C:\CAPER_Data
echo.

pause
