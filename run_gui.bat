@echo off
REM CAPER Suite - GUI Launcher for Windows

echo ====================================
echo CAPER Suite - GUI Launcher
echo ====================================
echo.

REM Check if Python is installed - try multiple commands
set PYTHON_CMD=
set PYTHON_FOUND=0

REM Try py launcher first (recommended for Windows)
py --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py
    set PYTHON_FOUND=1
    goto :python_found
)

REM Try python3 command
python3 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python3
    set PYTHON_FOUND=1
    goto :python_found
)

REM Try python command
python --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python
    set PYTHON_FOUND=1
    goto :python_found
)

REM No Python found
:python_not_found
echo ERROR: Python is not installed or not in PATH
echo.
echo Please install Python 3.7 or higher from https://www.python.org/
echo Make sure to check "Add Python to PATH" during installation
echo.
echo Troubleshooting:
echo   1. Check if Python is installed: Open Command Prompt and try "py --version"
echo   2. If using Microsoft Store Python, try uninstalling and installing from python.org
echo   3. Make sure Python is added to your system PATH
echo.
pause
exit /b 1

:python_found
echo Found Python: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

REM Launch the GUI
echo Launching CAPER Suite GUI...
echo.
%PYTHON_CMD% psychology_client_gui.py

REM If there was an error
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to launch GUI
    pause
)
