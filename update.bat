@echo off
REM Update CAPER Suite to latest version
echo ====================================
echo CAPER Suite - Update Script
echo ====================================
echo.
echo This will update your local copy to the latest version.
echo.
pause

cd /d "%~dp0"

echo Checking for updates...
git fetch origin
echo.

echo Current branch:
git branch --show-current
echo.

echo Getting latest changes...
git pull origin claude/remake-cli-interface-011CUW2fmm36R36VbXE5Y9uW
echo.

if %errorlevel% equ 0 (
    echo ====================================
    echo Update completed successfully!
    echo ====================================
) else (
    echo ====================================
    echo Update failed - please check errors above
    echo ====================================
)

echo.
pause
