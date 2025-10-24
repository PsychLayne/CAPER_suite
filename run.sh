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

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed or not in PATH"
    echo ""
    echo "Please install Python 3.7 or higher:"
    echo "  Ubuntu/Debian: sudo apt-get install python3"
    echo "  macOS: brew install python3"
    echo "  Fedora: sudo dnf install python3"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

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
python3 "$SCRIPT_DIR/psychology_client.py"

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
