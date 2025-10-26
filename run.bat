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

REM Try to find Python in common installation locations
for %%P in (
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python310\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python39\python.exe"
    "%PROGRAMFILES%\Python312\python.exe"
    "%PROGRAMFILES%\Python311\python.exe"
    "%PROGRAMFILES%\Python310\python.exe"
    "C:\Python312\python.exe"
    "C:\Python311\python.exe"
    "C:\Python310\python.exe"
) do (
    if exist %%P (
        %%P --version 2>&1 | findstr /C:"Python 3" >nul
        if %errorlevel% equ 0 (
            set PYTHON_CMD=%%P
            set PYTHON_FOUND=1
            goto :python_found
        )
    )
)

REM No Python found
:python_not_found
echo ERROR: Python 3 is not installed or not in PATH
echo.
echo Python is installed but this script cannot find it.
echo.
echo See QUICK_FIX_PYTHON_NOT_FOUND.txt for detailed solutions.
echo.
echo Quick fixes:
echo   1. Add Python to PATH (see QUICK_FIX_PYTHON_NOT_FOUND.txt)
echo   2. Or reinstall Python and CHECK "Add Python to PATH"
echo   3. Or try: py "%~dp0psychology_client.py" (use py launcher)
echo.
echo Python download: https://www.python.org/downloads/
echo IMPORTANT: Check "Add Python to PATH" during installation!
echo.
pause
exit /b 1

:python_found
echo Found Python: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

REM Check if psychology_client.py exists
if not exist "%~dp0src\psychology_client.py" (
    echo ERROR: psychology_client.py not found!
    echo Make sure you're running this script from the CAPER_suite directory
    echo.
    pause
    exit /b 1
)

REM Launch the client
echo Starting Psychology Client...
echo.
%PYTHON_CMD% "%~dp0src\psychology_client.py"

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
