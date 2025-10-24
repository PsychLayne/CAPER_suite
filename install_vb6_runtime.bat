@echo off
REM Launcher for VB6 Runtime Installer
REM Keeps the window open so you can see any errors

echo ============================================================================
echo VB6 RUNTIME INSTALLER FOR CAPER SUITE
echo ============================================================================
echo.
echo This script will help you install the Visual Basic 6.0 runtime libraries
echo that are required to run the psychology tasks.
echo.
echo IMPORTANT: You should run this as Administrator!
echo.
echo If you're not running as Administrator:
echo   1. Close this window
echo   2. Right-click this file: install_vb6_runtime.bat
echo   3. Select "Run as Administrator"
echo.
echo ============================================================================
echo.
pause

REM Try to run the Python script
python install_vb6_runtime.py

REM Check if Python command succeeded
if errorlevel 1 (
    echo.
    echo ============================================================================
    echo ERROR: The installer encountered a problem
    echo ============================================================================
    echo.
    echo Possible causes:
    echo   - Python is not installed or not in PATH
    echo   - You need to run as Administrator
    echo   - The install_vb6_runtime.py file is missing
    echo.
    echo Try running from Command Prompt instead:
    echo   1. Open Command Prompt as Administrator
    echo   2. Navigate to this folder: cd /d "%~dp0"
    echo   3. Run: python install_vb6_runtime.py
    echo.
)

echo.
echo ============================================================================
echo Press any key to close this window...
echo ============================================================================
pause > nul
