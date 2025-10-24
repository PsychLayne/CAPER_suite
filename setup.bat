@echo off
REM One-Click Setup for CAPER Suite
REM Automatically downloads and installs all requirements including VB6 Runtime

echo ============================================================================
echo CAPER SUITE - ONE-CLICK SETUP
echo ============================================================================
echo.
echo This script will automatically set up everything you need:
echo   - Install Python packages
echo   - Download and install VB6 Runtime SP6
echo   - Verify system requirements
echo   - Create necessary directories
echo.
echo IMPORTANT: For VB6 Runtime installation, you MUST run as Administrator!
echo.
echo If you're not running as Administrator:
echo   1. Close this window
echo   2. Right-click this file: setup.bat
echo   3. Select "Run as Administrator"
echo   4. Run again
echo.
echo ============================================================================
echo.
pause

REM Change to the script's directory
cd /d "%~dp0"

REM Try to find Python
echo Searching for Python...
echo.

REM First, try py launcher (most reliable on Windows)
py --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python Launcher (py)
    py --version
    echo.
    echo Starting setup...
    echo.
    py setup.py
    goto :end
)

REM Try python command
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python in PATH
    python --version
    echo.
    echo Starting setup...
    echo.
    python setup.py
    goto :end
)

REM Try python3 command
python3 --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python3 in PATH
    python3 --version
    echo.
    echo Starting setup...
    echo.
    python3 setup.py
    goto :end
)

REM Try common Python installation locations
echo Python not in PATH, searching common installation locations...
echo.

for %%P in (
    "%LOCALAPPDATA%\Programs\Python\Python314\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python313\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python310\python.exe"
    "%PROGRAMFILES%\Python314\python.exe"
    "%PROGRAMFILES%\Python313\python.exe"
    "%PROGRAMFILES%\Python312\python.exe"
    "C:\Python314\python.exe"
    "C:\Python313\python.exe"
    "C:\Python312\python.exe"
) do (
    if exist %%P (
        REM Test if this Python actually works
        %%P --version >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            echo Found Python at: %%P
            %%P --version
            echo.
            echo Starting setup...
            echo.
            %%P setup.py
            goto :end
        )
    )
)

REM Python not found
echo.
echo ============================================================================
echo ERROR: Python not found
echo ============================================================================
echo.
echo Python is required to run CAPER Suite.
echo.
echo Please install Python 3.7 or higher from:
echo   https://www.python.org/downloads/
echo.
echo IMPORTANT: During installation, CHECK the box "Add Python to PATH"!
echo.
echo After installing Python, run this setup again.
echo.
echo ============================================================================
pause
exit /b 1

:end
echo.
echo ============================================================================
echo Setup script finished
echo ============================================================================
echo.
pause
