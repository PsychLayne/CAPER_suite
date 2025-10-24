#!/bin/bash
# CAPER Suite Psychology Client Launcher (Linux/Mac)
# This script launches the psychology client with proper error handling

echo ""
echo "================================================================================"
echo " CAPER SUITE - PSYCHOLOGY CLIENT LAUNCHER"
echo "================================================================================"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

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

# Check if psychology_client.py exists
if [ ! -f "$SCRIPT_DIR/psychology_client.py" ]; then
    echo "ERROR: psychology_client.py not found!"
    echo "Make sure you're running this script from the CAPER_suite directory"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

# Launch the client
echo "Starting Psychology Client..."
echo ""
$PYTHON_CMD "$SCRIPT_DIR/psychology_client.py"

# Check exit code
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "================================================================================"
    echo " Client exited with an error (code: $EXIT_CODE)"
    echo "================================================================================"
    echo ""
    read -p "Press Enter to exit..."
    exit $EXIT_CODE
fi

exit 0
