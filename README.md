# CAPER Suite - Psychology Client

**Unified Task Launcher for Research Psychology**

This client provides an easy-to-use interface for running all CAPER (Computerized Assessment of Psychological and Experimental Research) psychology tasks. With a simple one-button setup, researchers can quickly launch and manage psychological assessments without needing to navigate complex directory structures or manage multiple executables.

---

## Overview

The CAPER Suite includes **8 psychology tasks** across 3 major categories:

### 📊 Available Tasks

#### **Auditory Processing Tests**
- **PASAT (Standard)** - Paced Auditory Serial Addition Test
- **PASAT 7550** - PASAT variant with 7550 Hz audio

#### **Risk-Taking Assessments**
- **BART - Automatic** - Automated Balloon Analogue Risk Task
- **BART - Adolescent** - Age-adapted version for adolescents
- **BART - Options** - Standard choice variant
- **BART - Options P** - Parametric options version
- **BART - BAIT** - Adaptive BAIT version

#### **Motor Coordination**
- **Mirror Task** - Mirror drawing task for motor coordination and learning

---

## Quick Start

### One-Button Setup

#### **Windows:**
1. Double-click `run.bat`
2. Or open Command Prompt in this folder and run:
   ```cmd
   run.bat
   ```

#### **Linux/Mac:**
1. Open Terminal in this folder and run:
   ```bash
   ./run.sh
   ```
   Or:
   ```bash
   bash run.sh
   ```

That's it! The client will launch and guide you through the available tasks.

---

## IMPORTANT: Windows Defender False Positive

**Windows users:** Windows Defender may flag PASAT and other executables as threats. This is a **false positive** - the files are legitimate research software built with Visual Basic 6.0 (early 2000s).

### Quick Fix:

1. **Automatic (Easiest):**
   - Right-click PowerShell and select "Run as Administrator"
   - Run: `.\add_windows_defender_exclusion.ps1`
   - Type 'Y' to confirm

2. **Manual:**
   - Open Windows Security → Virus & threat protection
   - Click "Manage settings" → "Exclusions"
   - Add the CAPER_suite folder as an exclusion

### More Information:
- See `QUICK_FIX_WINDOWS_DEFENDER.txt` for simple instructions
- See `WINDOWS_DEFENDER_FALSE_POSITIVE.md` for complete technical details

**This is safe:** The executables are legitimate psychology research tools with no malicious code. File hashes are documented for verification.

---

## Installation

### Prerequisites

- **Python 3.7 or higher**
- **Operating System:**
  - Windows XP or later (native support)
  - Linux/Mac with Wine installed
- **Hardware:**
  - Sound card (for audio tasks)
  - Display: 800x600 minimum resolution

### One-Click Setup (Recommended)

**Windows:**
1. **Right-click** `setup.bat` and select **"Run as Administrator"**
2. Press Enter to begin
3. Type `y` when prompted to install VB6 Runtime
4. Wait for automatic download and installation
5. Done! Everything is configured automatically.

**Or manually:**
```cmd
python setup.py
```

**What it does:**
- ✓ Checks Python version
- ✓ Installs Python packages automatically
- ✓ **Downloads and installs VB6 Runtime SP6** (Windows only, ~1.4 MB)
- ✓ Verifies system requirements
- ✓ Creates necessary directories
- ✓ Tests the installation

**Linux/Mac:**
1. Install Wine first (if not already installed):
   ```bash
   # Ubuntu/Debian
   sudo apt-get install wine

   # Fedora
   sudo dnf install wine

   # macOS
   brew install wine-stable
   ```

2. Run setup:
   ```bash
   python setup.py
   ```

---

## Usage

### Launching the Client

Use one of these methods:

1. **Double-click the launcher:**
   - Windows: `run.bat`
   - Linux/Mac: Make `run.sh` executable first: `chmod +x run.sh`, then run it

2. **From command line:**
   ```bash
   python psychology_client.py
   ```

3. **As a Python module:**
   ```bash
   python -m psychology_client
   ```

### Using the Client

Once launched, you'll see a main menu with these options:

1. **List All Tasks** - View all available psychology tasks with descriptions
2. **Launch a Task** - Select and run a specific task
3. **View Task Information** - Get detailed info about a task
4. **System Information** - Check your system configuration
5. **Verify System Requirements** - Run diagnostics
6. **Help** - View help documentation
7. **Quit** - Exit the client

### Running a Task

1. Select **"Launch a Task"** from the main menu
2. Choose a task by entering its number (1-8)
3. Review the task information
4. Confirm to launch
5. The task will open in a new window
6. Follow the task's on-screen instructions
7. Data will be saved automatically

---

## Data Management

### Data Storage

- **Task Data:** Saved in each task's directory
  - PASAT: `PASAT/PASAT_Stnd.mdb`
  - BART variants: `bart_*/[variant].mdb`
  - Mirror Task: `MT/MIRROROUT.TXT`

- **Backups:** Automatically created before each task run
  - Location: `data_backup/`
  - Format: `[task]_[database]_[timestamp]`

- **Exports:** Can be saved to
  - Location: `data_output/`

### Accessing Data

#### **Windows:**
- Open `.mdb` files with Microsoft Access
- View `.txt` files with any text editor

#### **Linux/Mac:**
- Install `mdbtools`:
  ```bash
  # Ubuntu/Debian
  sudo apt-get install mdbtools

  # macOS
  brew install mdbtools
  ```
- Export data:
  ```bash
  mdb-tables database.mdb           # List tables
  mdb-export database.mdb TableName # Export table
  ```

---

## Task Descriptions

### PASAT (Paced Auditory Serial Addition Test)

**Purpose:** Tests auditory processing speed and working memory

**How it works:**
- Listen to single-digit numbers
- Add each new number to the previous one
- Speak your answer
- Continue with rapid succession

**Measures:**
- Response accuracy
- Response latency
- Error counts
- Total completion time

**Target:** General adult population

---

### BART (Balloon Analogue Risk Task)

**Purpose:** Assesses risk-taking behavior and decision-making

**How it works:**
- Pump up virtual balloons to earn money
- Each pump increases potential reward
- But balloon can pop at any time
- If it pops, you lose all money from that balloon
- Balance risk vs. reward across trials

**Measures:**
- Number of pumps per trial
- Risk-taking patterns
- Earnings (successful trials)
- Adjustment strategies
- Risk propensity score

**Variants:**
- **Automatic:** Computer-controlled pumping
- **Adolescent:** Adapted for younger participants
- **Options:** Choice-based variant
- **Options P:** Parametric version
- **BAIT:** Adaptive difficulty

**Target:** All ages (use appropriate variant)

---

### Mirror Task

**Purpose:** Tests motor coordination, learning, and adaptation

**How it works:**
- Draw or trace shapes
- Vision is reversed (mirror image)
- Must adapt motor control to visual feedback
- Multiple trials measure learning

**Measures:**
- Error count
- Completion time
- Drawing accuracy (distance metrics)
- Learning curve
- Pre/post mood ratings

**Target:** General population

---

## Troubleshooting

### Common Issues

#### **"System Error &H8007007E - Module Not Found" (MOST COMMON)**
- **Error:** "System Error &H8007007E (-2147024770). The specified module could not be found."
- **Cause:** Visual Basic 6.0 runtime libraries (DLLs) are missing from Windows
- **Solution:** Install VB6 Runtime SP6
- **Quick Fix:**
  1. Check dependencies: `python check_vb6_dependencies.py`
  2. Install runtime (as Administrator): `python install_vb6_runtime.py`
  3. Verify fix: `python check_vb6_dependencies.py`
- **Manual Installation:**
  - Download VB6 Runtime SP6: https://www.microsoft.com/en-us/download/details.aspx?id=24417
  - Run VBRun60sp6.exe as Administrator
  - Restart your computer
- See `QUICK_FIX_MODULE_NOT_FOUND.txt` for detailed instructions

#### **Windows Defender flagging tasks as viruses**
- This is a **false positive** - the files are safe
- The executables are old VB6 applications that trigger heuristic detection
- **Solution:** Add CAPER_suite folder to Windows Defender exclusions
- **Automatic fix:** Run `.\add_windows_defender_exclusion.ps1` as Administrator
- **Manual fix:** Windows Security → Virus & threat protection → Manage settings → Exclusions → Add folder
- See `QUICK_FIX_WINDOWS_DEFENDER.txt` or `WINDOWS_DEFENDER_FALSE_POSITIVE.md` for details

#### **"Python not found" error**
- Install Python 3.7+ from python.org
- Make sure "Add to PATH" is checked during installation
- Restart your terminal/command prompt after installation

#### **"Wine not found" (Linux/Mac)**
- Install Wine: See installation instructions above
- Check installation: `wine --version`
- Restart terminal after installation

#### **Task won't launch**
- Verify the task executable exists in its directory
- Run "Verify System Requirements" from the main menu
- Check that you have necessary permissions

#### **No sound in audio tasks**
- Check that your sound card is working
- Verify volume is not muted
- Test with other audio applications first

#### **Database access errors**
- Ensure Microsoft Jet 3.5 engine is installed (Windows)
- Check file permissions on .mdb files
- Use mdbtools on Linux/Mac

#### **"Module not found" errors**
- Run `python setup.py` again
- Manually install: `pip install -r requirements.txt`
- Check Python version: `python --version`

---

## File Structure

```
CAPER_suite/
├── README.md                 # Main documentation
├── TROUBLESHOOTING.md        # Troubleshooting guide
├── requirements.txt          # Python dependencies
├── .gitignore                # Git ignore patterns
│
├── setup.bat                 # One-button setup (Windows)
├── run.bat                   # CLI launcher (Windows)
├── run.sh                    # CLI launcher (Linux/Mac)
├── run_gui.bat               # GUI launcher (Windows)
├── run_gui.sh                # GUI launcher (Linux/Mac)
│
├── src/                      # Python source code
│   ├── psychology_client.py      # Main CLI application
│   ├── psychology_client_gui.py  # Main GUI application
│   ├── task_manager.py           # Task execution handler
│   ├── config.py                 # Task configuration
│   ├── launch_gui_1024.py        # GUI with resolution management
│   └── resolution_trick.py       # Resolution utilities
│
├── installers/               # Installation files
│   └── vbrun60sp6.exe           # VB6 Runtime installer
│
├── tasks/                    # Psychology task applications
│   ├── PASAT/                    # PASAT Standard task
│   │   ├── PASAT_Stnd.exe
│   │   ├── PASAT_Stnd.mdb
│   │   └── ...
│   │
│   ├── PASAT_7550/              # PASAT 7550 variant
│   │   └── ...
│   │
│   ├── bart_auto/               # BART Automatic
│   │   └── ...
│   │
│   ├── bart_adol/               # BART Adolescent
│   │   └── ...
│   │
│   ├── bart_options/            # BART Options
│   │   └── ...
│   │
│   ├── BART_Options_P/          # BART Options P
│   │   └── ...
│   │
│   ├── BART_BAIT/               # BART BAIT
│   │   └── ...
│   │
│   ├── BIRD_Basic/              # BIRD Basic task
│   │   └── ...
│   │
│   └── MT/                      # Mirror Task
│       ├── Mirror b5.exe
│       ├── MIRROROUT.TXT
│       ├── CODEBOOK.TXT
│       └── ...
│
├── docs/                     # Documentation files
│   ├── FIX_VB6_RUNTIME.md
│   ├── GUI_README.md
│   ├── PYTHON_NOT_FOUND.md
│   ├── VB6_DOWNLOAD_SOURCES.md
│   └── WINDOWS_DEFENDER_FALSE_POSITIVE.md
│
├── scripts/                  # Utility scripts
│   ├── add_windows_defender_exclusion.ps1
│   ├── check_vb6_dependencies.bat
│   └── check_vb6_dependencies.py
│
├── data_output/              # Exported data files (created automatically)
└── data_backup/              # Automatic backups (created automatically)
```

---

## Technical Details

### System Requirements

**Minimum:**
- Python 3.7+
- Windows XP or later (or Wine 5.0+ on Linux/Mac)
- 100 MB free disk space
- 512 MB RAM
- 800x600 display resolution
- Sound card

**Recommended:**
- Python 3.9+
- Windows 10 or later
- 500 MB free disk space
- 2 GB RAM
- 1024x768 display resolution
- Quality sound card/speakers

### Dependencies

The client requires these Python packages (auto-installed by setup.py):
- tkinter-tooltip (GUI enhancements)
- pyodbc (database access)
- pandas (data handling)
- openpyxl (Excel export)
- psutil (system utilities)
- pyyaml (configuration)
- python-dateutil (date/time handling)
- pywin32 (Windows only)

### Technology Stack

**Original Tasks:**
- Visual Basic 6.0 applications
- Microsoft Access 2000 databases (.mdb)
- Windows Common Controls
- Media Control Interface (MCI) for audio

**Client:**
- Python 3.7+
- Cross-platform compatibility
- Command-line interface
- Automated data management

---

## For Researchers

### Data Collection

Each task automatically saves data to its respective database or output file. The client creates automatic backups before each run to prevent data loss.

### Data Export

To export data for analysis:
1. Use the client's export features (coming soon)
2. Access .mdb files directly with Access or mdbtools
3. Parse .txt output files (tab-delimited format)

### Citing This Software

If you use CAPER Suite in your research, please cite:

```
CAPER Suite - Computerized Assessment of Psychology and Experimental Research
Psychology Client Version 1.0
[Add appropriate citation information]
```

### Ethics and IRB

Ensure you have appropriate IRB approval for your research protocol before administering these tasks to participants.

---

## Support

### Getting Help

1. **Check the Help menu** in the client
2. **Review this README**
3. **Check task-specific documentation** in each task directory (.doc files)
4. **Verify system requirements** using the client's verification tool

### Reporting Issues

If you encounter bugs or issues:
1. Run "Verify System Requirements" in the client
2. Document the exact error message
3. Note your operating system and Python version
4. Check if the issue occurs with all tasks or just one

---

## License

[Add appropriate license information]

---

## Version History

### Version 1.0.0 (Current)
- Initial release
- Unified client for all 8 psychology tasks
- One-button setup
- Automatic data backup
- Cross-platform support (Windows/Linux/Mac)
- Interactive menu system

---

## Contributing

[Add contribution guidelines if applicable]

---

## Acknowledgments

CAPER Suite tasks developed for psychological and behavioral research. Client interface designed for ease of use in research settings.

---

**Happy researching!**
