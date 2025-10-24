@echo off
REM CAPER Suite Psychology Client Launcher (Windows)
REM This script launches the psychology client with proper error handling

echo.
echo ================================================================================
echo  CAPER SUITE - PSYCHOLOGY CLIENT LAUNCHER
echo ================================================================================
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
%PYTHON_CMD% "%~dp0psychology_client.py"

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
