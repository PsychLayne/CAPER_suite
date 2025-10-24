@echo off
REM CAPER Suite Psychology Client Launcher (Windows)
REM This script launches the psychology client with proper error handling

echo.
echo ================================================================================
echo  CAPER SUITE - PSYCHOLOGY CLIENT LAUNCHER
echo ================================================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo.
    echo Please install Python 3.7 or higher from https://www.python.org/
    echo Make sure to check "Add Python to PATH" during installation
    echo.
    pause
    exit /b 1
)

REM Check if psychology_client.py exists
if not exist "%~dp0psychology_client.py" (
    echo ERROR: psychology_client.py not found!
    echo Make sure you're running this script from the CAPER_suite directory
    echo.
    pause
    exit /b 1
)

REM Launch the client
echo Starting Psychology Client...
echo.
python "%~dp0psychology_client.py"

REM Check exit code
if errorlevel 1 (
    echo.
    echo ================================================================================
    echo  Client exited with an error
    echo ================================================================================
    echo.
    pause
    exit /b 1
)

exit /b 0
