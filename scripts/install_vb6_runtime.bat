@echo off
REM Launcher for VB6 Runtime Installer
REM Automatically finds Python even if not in PATH

echo ============================================================================
echo VB6 RUNTIME INSTALLER FOR CAPER SUITE
echo ============================================================================
echo.
echo This script will help you install the Visual Basic 6.0 runtime libraries
echo that are required to run the psychology tasks.
echo.
echo IMPORTANT: You should run this as Administrator!
echo.
echo If you're not running as Administrator:
echo   1. Close this window
echo   2. Right-click this file: install_vb6_runtime.bat
echo   3. Select "Run as Administrator"
echo.
echo ============================================================================
echo.
pause

REM Try to find Python
echo Searching for Python...
echo.

REM First, try py launcher (most reliable on Windows)
py --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python Launcher (py)
    py --version
    echo.
    py install_vb6_runtime.py
    goto :end
)

REM Try python command - TEST it, don't just check if it exists
REM (Microsoft Store stub will fail this test)
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python in PATH
    python --version
    echo.
    python install_vb6_runtime.py
    goto :end
)

REM Try python3 command
python3 --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python3 in PATH
    python3 --version
    echo.
    python3 install_vb6_runtime.py
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
            %%P install_vb6_runtime.py
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
echo   1. Press Windows key and type "environment"
echo   2. Click "Edit the system environment variables"
echo   3. Click "Environment Variables" button
echo   4. Under "User variables", find "Path" and click "Edit"
echo   5. Click "New" and add your Python installation path
echo      Common locations:
echo        %LOCALAPPDATA%\Programs\Python\Python312
echo        %LOCALAPPDATA%\Programs\Python\Python311
echo        C:\Python312
echo   6. Click OK on all windows
echo   7. Close and reopen this script
echo.
echo OPTION 3: Use py Launcher
echo ---------------------------------------------------------------------------
echo   If Python is installed but not in PATH, try:
echo   1. Open Command Prompt as Administrator
echo   2. Navigate to: cd /d "%~dp0"
echo   3. Run: py install_vb6_runtime.py
echo.
echo OPTION 4: Manual Python Path
echo ---------------------------------------------------------------------------
echo   1. Download Python from: https://www.python.org/downloads/
echo   2. Run the installer
echo   3. CHECK THE BOX: "Add Python to PATH" (IMPORTANT!)
echo   4. Complete the installation
echo   5. Close and reopen this script
echo.
echo OPTION 5: Skip Python - Install VB6 Runtime Manually
echo ---------------------------------------------------------------------------
echo   Skip Python entirely and install VB6 Runtime manually:
echo   1. Go to: https://www.microsoft.com/en-us/download/details.aspx?id=24417
echo   2. Download VBRun60sp6.exe
echo   3. Right-click VBRun60sp6.exe
echo   4. Select "Run as Administrator"
echo   5. Follow the installation wizard
echo.
goto :end

:end
echo.
echo ============================================================================
echo Press any key to close this window...
echo ============================================================================
pause > nul
