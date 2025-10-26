@echo off
REM CAPER Suite - GUI Launcher for Windows

REM Change to the directory where this batch file is located
cd /d "%~dp0"

echo ====================================
echo CAPER Suite - GUI Launcher
echo ====================================
echo.

REM Check if Python is installed - try multiple commands
set PYTHON_CMD=
set PYTHON_FOUND=0

REM Try py launcher first (recommended for Windows, works with Python 3.14+)
py --version >nul 2>&1
if %errorlevel% equ 0 (
    REM Verify it's Python 3
    py --version 2>&1 | findstr /C:"Python 3" >nul
    if %errorlevel% equ 0 (
        set PYTHON_CMD=py
        set PYTHON_FOUND=1
        goto :python_found
    )
)

REM Try python3 command
python3 --version >nul 2>&1
if %errorlevel% equ 0 (
    python3 --version 2>&1 | findstr /C:"Python 3" >nul
    if %errorlevel% equ 0 (
        set PYTHON_CMD=python3
        set PYTHON_FOUND=1
        goto :python_found
    )
)

REM Try python command
python --version >nul 2>&1
if %errorlevel% equ 0 (
    python --version 2>&1 | findstr /C:"Python 3" >nul
    if %errorlevel% equ 0 (
        set PYTHON_CMD=python
        set PYTHON_FOUND=1
        goto :python_found
    )
)

REM No Python found
:python_not_found
echo ERROR: Python 3 is not installed or not in PATH
echo.
echo Please install Python 3.7 or higher from https://www.python.org/
echo Make sure to check "Add Python to PATH" during installation
echo.
echo Troubleshooting:
echo   1. Check if Python is installed: Open Command Prompt and try "py --version"
echo   2. Try "python --version" or "python3 --version"
echo   3. If using Microsoft Store Python, try uninstalling and installing from python.org
echo   4. Make sure Python is added to your system PATH
echo   5. Restart your terminal/command prompt after installing Python
echo   6. For Python 3.14+, use the 'py' launcher or ensure Python is in PATH
echo.
pause
exit /b 1

:python_found
echo Found Python: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

REM Launch the GUI with resolution management
echo Launching CAPER Suite GUI...
echo.
echo NOTE: Screen will change to 1024x768 for optimal task display
echo      Resolution will be restored when you close the GUI
echo.
%PYTHON_CMD% src\launch_gui_1024.py

REM If there was an error
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to launch GUI
    pause
)
