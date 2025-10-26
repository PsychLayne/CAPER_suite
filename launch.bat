@echo off
REM CAPER Suite - GUI Launcher

echo ====================================
echo CAPER Suite - GUI Launcher
echo ====================================
echo.

REM Change to the script's directory
cd /d "%~dp0"

REM Try to find Python
set PYTHON_CMD=
set PYTHON_FOUND=0

REM Try py launcher first (recommended for Windows)
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
echo Please run setup.bat first to install all requirements.
echo.
echo If you've already run setup, make sure Python is installed:
echo   - Download from https://www.python.org/
echo   - Check "Add Python to PATH" during installation
echo   - Restart your terminal after installation
echo.
pause
exit /b 1

:python_found
echo Found Python: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

REM Check if setup was run
if not exist "data_output" (
    echo WARNING: Setup may not have been completed!
    echo          Please run setup.bat first if you encounter any errors.
    echo.
)

REM Launch the GUI with resolution management
echo Launching CAPER Suite GUI...
echo.
echo NOTE: Screen will change to 1024x768 for optimal task display
echo      Resolution will be restored when you close the GUI
echo.
%PYTHON_CMD% launch_gui_1024.py

REM If there was an error
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to launch GUI
    echo.
    echo Please make sure you've run setup.bat first.
    echo If the problem persists, check the error messages above.
    echo.
    pause
    exit /b 1
)
