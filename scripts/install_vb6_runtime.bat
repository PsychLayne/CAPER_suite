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

REM First, try python in PATH
where python >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python in PATH
    python install_vb6_runtime.py
    goto :end
)

REM Try py launcher (Windows Python Launcher)
where py >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Found Python Launcher
    py install_vb6_runtime.py
    goto :end
)

REM Try common Python installation locations
set PYTHON_LOCATIONS=^
    "%LOCALAPPDATA%\Programs\Python\Python*\python.exe"^
    "%PROGRAMFILES%\Python*\python.exe"^
    "%PROGRAMFILES(X86)%\Python*\python.exe"^
    "%USERPROFILE%\AppData\Local\Programs\Python\Python*\python.exe"^
    "C:\Python*\python.exe"

for %%L in (%PYTHON_LOCATIONS%) do (
    for %%P in (%%L) do (
        if exist "%%P" (
            echo Found Python at: %%P
            "%%P" install_vb6_runtime.py
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
echo Python is installed but this script cannot find it.
echo.
echo OPTION 1: Add Python to PATH (Recommended)
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
echo OPTION 2: Manual Python Path
echo ---------------------------------------------------------------------------
echo   1. Find where Python is installed on your computer
echo   2. Open Command Prompt as Administrator
echo   3. Run: cd /d "%~dp0"
echo   4. Run: "C:\path\to\python.exe" install_vb6_runtime.py
echo      (Replace C:\path\to\python.exe with your actual Python path)
echo.
echo OPTION 3: Reinstall Python
echo ---------------------------------------------------------------------------
echo   1. Download Python from: https://www.python.org/downloads/
echo   2. Run the installer
echo   3. CHECK THE BOX: "Add Python to PATH" (IMPORTANT!)
echo   4. Complete the installation
echo   5. Close and reopen this script
echo.
echo OPTION 4: Manual VB6 Runtime Installation
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
