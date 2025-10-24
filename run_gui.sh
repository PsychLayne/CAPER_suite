#!/bin/bash
# CAPER Suite - GUI Launcher for Linux/Mac

echo "===================================="
echo "CAPER Suite - GUI Launcher"
echo "===================================="
echo ""

# Check if Python 3 is installed - try multiple commands
PYTHON_CMD=""

# Function to check if a command is Python 3
check_python3() {
    local cmd=$1
    # Try to get version and check if it starts with "Python 3"
    local version_output=$($cmd --version 2>&1)
    if echo "$version_output" | grep -q "^Python 3"; then
        echo "$cmd"
        return 0
    fi
    return 1
}

# Try python3 first (preferred on Linux/Mac)
if command -v python3 &> /dev/null; then
    if FOUND_CMD=$(check_python3 "python3"); then
        PYTHON_CMD="$FOUND_CMD"
    fi
fi

# If not found, try python command
if [ -z "$PYTHON_CMD" ] && command -v python &> /dev/null; then
    if FOUND_CMD=$(check_python3 "python"); then
        PYTHON_CMD="$FOUND_CMD"
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
    echo "  4. Try running: python3 --version"
    echo "  5. Try running: python --version"
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
