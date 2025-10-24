#!/bin/bash
# CAPER Suite - GUI Launcher for Linux/Mac

echo "===================================="
echo "CAPER Suite - GUI Launcher"
echo "===================================="
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed"
    echo "Please install Python 3.7 or later"
    exit 1
fi

# Launch the GUI
echo "Launching CAPER Suite GUI..."
echo ""
python3 psychology_client_gui.py

# Check exit status
if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Failed to launch GUI"
    read -p "Press Enter to exit..."
fi
