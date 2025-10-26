@echo off
REM Quick test launcher for GUI (no resolution change)
cd /d "%~dp0"
echo Testing CAPER Suite GUI...
echo.
py -3 src\psychology_client_gui.py
if %errorlevel% neq 0 (
    echo.
    echo ERROR: GUI failed to launch
    pause
)
