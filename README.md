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

## Installation

### Prerequisites

- **Python 3.7 or higher**
- **Operating System:**
  - Windows XP or later (native support)
  - Linux/Mac with Wine installed
- **Hardware:**
  - Sound card (for audio tasks)
  - Display: 800x600 minimum resolution

### First-Time Setup

1. **Install Python** (if not already installed):
   - **Windows:** Download from [python.org](https://www.python.org/downloads/)
   - **Linux:** `sudo apt-get install python3` (Ubuntu/Debian)
   - **Mac:** `brew install python3`

2. **Run the setup script:**
   ```bash
   python setup.py
   ```

   This will:
   - Check your Python version
   - Install required packages
   - Verify system requirements
   - Create necessary directories
   - Test the installation

3. **Linux/Mac only:** Install Wine (if not already installed):
   ```bash
   # Ubuntu/Debian
   sudo apt-get install wine

   # Fedora
   sudo dnf install wine

   # macOS
   brew install wine-stable
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
├── psychology_client.py      # Main client application
├── task_manager.py           # Task execution handler
├── config.py                 # Task configuration
├── setup.py                  # One-button setup script
├── requirements.txt          # Python dependencies
├── run.bat                   # Windows launcher
├── run.sh                    # Linux/Mac launcher
├── README.md                 # This file
│
├── data_output/              # Exported data files
├── data_backup/              # Automatic backups
│
├── PASAT/                    # PASAT Standard task
│   ├── PASAT_Stnd.exe
│   ├── PASAT_Stnd.mdb
│   └── ...
│
├── PASAT_7550/              # PASAT 7550 variant
│   └── ...
│
├── bart_auto/               # BART Automatic
│   └── ...
│
├── bart_adol/               # BART Adolescent
│   └── ...
│
├── bart_options/            # BART Options
│   └── ...
│
├── BART_Options_P/          # BART Options P
│   └── ...
│
├── BART_BAIT/               # BART BAIT
│   └── ...
│
└── MT/                      # Mirror Task
    ├── Mirror b5.exe
    ├── MIRROROUT.TXT
    ├── CODEBOOK.TXT
    └── ...
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
