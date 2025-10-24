@echo off
REM Launcher for VB6 Dependency Checker
REM Automatically finds Python even if not in PATH

echo ============================================================================
echo VB6 DEPENDENCY CHECKER FOR CAPER SUITE
echo ============================================================================
echo.
echo This script will check if all required Visual Basic 6.0 runtime libraries
echo are installed on your system.
echo.
echo ============================================================================
echo.
pause

REM Change to the script's directory (important when running as Administrator)
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
    py "%~dp0check_vb6_dependencies.py"
    goto :end
)

REM Try python command - TEST it, don't just check if it exists
REM (Microsoft Store stub will fail this test)
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python in PATH
    python --version
    echo.
    python "%~dp0check_vb6_dependencies.py"
    goto :end
)

REM Try python3 command
python3 --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python3 in PATH
    python3 --version
    echo.
    python3 "%~dp0check_vb6_dependencies.py"
    goto :end
)

REM Try common Python installation locations
echo Python not in PATH, searching common installation locations...
echo.

for %%P in (
    "%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python310\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python39\python.exe"
    "%LOCALAPPDATA%\Programs\Python\Python38\python.exe"
    "%PROGRAMFILES%\Python312\python.exe"
    "%PROGRAMFILES%\Python311\python.exe"
    "%PROGRAMFILES%\Python310\python.exe"
    "%PROGRAMFILES(X86)%\Python312\python.exe"
    "%PROGRAMFILES(X86)%\Python311\python.exe"
    "C:\Python312\python.exe"
    "C:\Python311\python.exe"
    "C:\Python310\python.exe"
    "C:\Python39\python.exe"
    "C:\Python38\python.exe"
) do (
    if exist %%P (
        REM Test if this Python actually works
        %%P --version >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            echo Found Python at: %%P
            %%P --version
            echo.
            %%P "%~dp0check_vb6_dependencies.py"
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
echo Python is either not installed or this script cannot find it.
echo.
echo OPTION 1: Disable Microsoft Store Python Alias (If Applicable)
echo ---------------------------------------------------------------------------
echo   If you see "Python was not found; run without arguments to install from
echo   the Microsoft Store" - you need to disable the Store alias:
echo.
echo   1. Press Windows key
echo   2. Type "Manage app execution aliases" and press Enter
echo   3. Find "App Installer" entries for python.exe and python3.exe
echo   4. Turn them OFF
echo   5. Then install Python with PATH (see Option 2)
echo.
echo OPTION 2: Install Python with PATH (Recommended)
echo ---------------------------------------------------------------------------
echo   1. Download Python from: https://www.python.org/downloads/
echo   2. Run the installer
echo   3. IMPORTANT: CHECK the box "Add Python to PATH" during installation!
echo   4. Complete the installation
echo   5. Close and reopen this script
echo.
echo OPTION 3: Use py Launcher
echo ---------------------------------------------------------------------------
echo   If Python is installed but not in PATH, try:
echo   1. Open Command Prompt
echo   2. Navigate to: cd /d "%~dp0"
echo   3. Run: py check_vb6_dependencies.py
echo.
echo See docs/PYTHON_NOT_FOUND.md for detailed instructions.
echo.

:end
echo.
echo ============================================================================
echo Press any key to close this window...
echo ============================================================================
pause > nul
