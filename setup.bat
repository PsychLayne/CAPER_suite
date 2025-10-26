@echo off
REM CAPER Suite - Simple Setup Script
REM Installs VB6 Runtime (included) and Python dependencies

echo ============================================================================
echo CAPER SUITE - SETUP
echo ============================================================================
echo.
echo This script will set up everything you need:
echo   - Install VB6 Runtime SP6 (included in this package)
echo   - Install Python packages
echo   - Create necessary directories
echo.
echo IMPORTANT: You MUST run as Administrator for VB6 Runtime installation!
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

REM Step 1: Install VB6 Runtime
echo.
echo [1/3] Installing VB6 Runtime SP6...
echo ----------------------------------------------------------------------------
if exist "installers\vbrun60sp6.exe" (
    echo Found VB6 Runtime installer: installers\vbrun60sp6.exe
    echo.
    echo Running installer (this may take a minute)...
    echo Please click through any prompts that appear.
    echo.

    REM Run the installer
    start /wait installers\vbrun60sp6.exe

    if %ERRORLEVEL% EQU 0 (
        echo.
        echo VB6 Runtime installation completed!
    ) else (
        echo.
        echo VB6 Runtime installer finished with code: %ERRORLEVEL%
        echo If you saw any errors, please run the installer manually.
    )
) else (
    echo ERROR: vbrun60sp6.exe not found in installers\ directory!
    echo Please make sure the installers directory contains vbrun60sp6.exe
    pause
    exit /b 1
)

echo.
echo ============================================================================
pause

REM Step 2: Install Python packages
echo.
echo [2/3] Installing Python packages...
echo ----------------------------------------------------------------------------

REM Try to find Python
set PYTHON_CMD=
set PYTHON_FOUND=0

REM Try py launcher first (most reliable on Windows)
py --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set PYTHON_CMD=py
    set PYTHON_FOUND=1
    goto :python_found
)

REM Try python command
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set PYTHON_CMD=python
    set PYTHON_FOUND=1
    goto :python_found
)

REM Try python3 command
python3 --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set PYTHON_CMD=python3
    set PYTHON_FOUND=1
    goto :python_found
)

REM Try common Python installation locations
for %%P in (
    "%LOCALAPPDATA%\Programs\Python\Python314\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python313\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    "%PROGRAMFILES%\Python314\python.exe"
    "%PROGRAMFILES%\Python313\python.exe"
    "%PROGRAMFILES%\Python312\python.exe"
) do (
    if exist %%P (
        %%P --version >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            set PYTHON_CMD=%%P
            set PYTHON_FOUND=1
            goto :python_found
        )
    )
)

REM Python not found
:python_not_found
echo.
echo ERROR: Python not found!
echo.
echo Python is required to run CAPER Suite.
echo Please install Python 3.7 or higher from:
echo   https://www.python.org/downloads/
echo.
echo IMPORTANT: During installation, CHECK the box "Add Python to PATH"!
echo.
pause
exit /b 1

:python_found
echo Found Python: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

REM Install packages
if exist "requirements.txt" (
    echo Installing packages from requirements.txt...
    echo This may take a few minutes...
    echo.
    %PYTHON_CMD% -m pip install -r requirements.txt

    if %ERRORLEVEL% EQU 0 (
        echo.
        echo Python packages installed successfully!
    ) else (
        echo.
        echo Warning: Some packages may have failed to install.
        echo The program may still work, but check for errors above.
    )
) else (
    echo Warning: requirements.txt not found!
)

echo.
echo ============================================================================
pause

REM Step 3: Create directories
echo.
echo [3/3] Creating directories...
echo ----------------------------------------------------------------------------

if not exist "data_output" mkdir data_output && echo Created: data_output/
if not exist "data_backup" mkdir data_backup && echo Created: data_backup/

echo.
echo ============================================================================
echo.
echo SETUP COMPLETE!
echo ============================================================================
echo.
echo Your CAPER Suite is ready to use!
echo.
echo IMPORTANT: Please restart your computer before running tasks
echo            for the first time (this ensures VB6 Runtime is properly loaded).
echo.
echo To launch the GUI, simply double-click: run_gui.bat
echo Or for the CLI version, double-click: run.bat
echo.
echo ============================================================================
echo.
pause
