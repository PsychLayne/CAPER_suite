#!/bin/bash
# CAPER Suite - GUI Launcher for Linux/Mac

echo "===================================="
echo "CAPER Suite - GUI Launcher"
echo "===================================="
echo ""

# Check if Python 3 is installed - try multiple commands
PYTHON_CMD=""

# Try python3 first (preferred on Linux/Mac)
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
# Try python command
elif command -v python &> /dev/null; then
    # Verify it's Python 3
    PYTHON_VERSION=$(python --version 2>&1 | grep -oP '(?<=Python )[0-9]+')
    if [ "$PYTHON_VERSION" = "3" ]; then
        PYTHON_CMD="python"
    fi
fi

# Check if we found a valid Python
if [ -z "$PYTHON_CMD" ]; then
    echo "ERROR: Python 3 is not installed or not in PATH"
    echo ""
    echo "Please install Python 3.7 or higher:"
    echo "  Ubuntu/Debian: sudo apt-get install python3"
    echo "  macOS: brew install python3"
    echo "  Fedora: sudo dnf install python3"
    echo ""
    echo "Troubleshooting:"
    echo "  1. Check if Python is installed: which python3"
    echo "  2. Check Python version: python3 --version"
    echo "  3. Make sure Python 3.7+ is in your PATH"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

echo "Found Python: $PYTHON_CMD"
$PYTHON_CMD --version
echo ""

# Launch the GUI
echo "Launching CAPER Suite GUI..."
echo ""
$PYTHON_CMD psychology_client_gui.py

# Check exit status
if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Failed to launch GUI"
    read -p "Press Enter to exit..."
fi
