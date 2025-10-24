@echo off
REM Launcher for VB6 Dependency Checker
REM Keeps the window open so you can see the results

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

REM Try to run the Python script
python check_vb6_dependencies.py

REM Check if Python command succeeded
if errorlevel 1 (
    echo.
    echo ============================================================================
    echo ERROR: The checker encountered a problem
    echo ============================================================================
    echo.
)

echo.
echo ============================================================================
echo Press any key to close this window...
echo ============================================================================
pause > nul
