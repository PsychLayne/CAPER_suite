@echo off
REM CAPER Suite - GUI Launcher for Windows

echo ====================================
echo CAPER Suite - GUI Launcher
echo ====================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.7 or later from https://www.python.org/
    pause
    exit /b 1
)

REM Launch the GUI
echo Launching CAPER Suite GUI...
echo.
python psychology_client_gui.py

REM If there was an error
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to launch GUI
    pause
)
