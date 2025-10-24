# CAPER Suite - Graphical User Interface

Welcome to the CAPER Suite GUI! This modern, user-friendly interface makes it easy to launch and manage psychology research tasks.

## 🚀 Quick Start

### Windows
Double-click `run_gui.bat` or run:
```bash
python psychology_client_gui.py
```

### Linux/Mac
Run the launcher script:
```bash
./run_gui.sh
```

Or manually with Python:
```bash
python3 psychology_client_gui.py
```

## 📋 Features

### 1. Tasks Tab
Browse and launch all 8 psychology assessment tasks organized by category:

- **🎧 Auditory Processing Tests**
  - PASAT - Standard
  - PASAT - 7550

- **🎈 Risk-Taking Assessments**
  - BART - Automatic
  - BART - Adolescent
  - BART - Options
  - BART - Options P
  - BART - BAIT

- **🎯 Motor Coordination**
  - Mirror Task

**Task Cards** display:
- Task name and purpose
- Availability status (✓ Ready / ✗ Not Found)
- Launch button
- Info button for detailed information

### 2. System Tab
View comprehensive system information:
- Operating system and platform
- Python version
- Wine installation (Linux/Mac)
- Task availability status
- System requirements verification

**Verify System Requirements** button checks if your system meets all requirements.

### 3. Data Tab
Manage task data, backups, and exports:

- **📦 View Backups** - Browse automatic backups created before each task run
- **📊 Export Data** - Export all task data to the output folder
- **📁 Open Data Folder** - Quick access to data_output directory
- **📂 Open Backup Folder** - Quick access to data_backup directory

### 4. Help Tab
Complete documentation including:
- How to use each tab
- System requirements
- Task descriptions
- Troubleshooting guide
- Support information

## 🎨 Design Features

### Professional & Modern
- Clean, card-based layout
- Color-coded categories (Purple for Auditory, Red for Risk-Taking, Blue for Motor)
- Status indicators with visual feedback
- Hover effects on buttons
- Responsive design

### User-Friendly
- Intuitive navigation with tabs
- Clear status messages in the footer
- System status in the header
- Confirmation dialogs before launching tasks
- Automatic backups before each task run

## 🔧 Technical Details

### Requirements
- Python 3.7+
- tkinter (usually included with Python)
- All dependencies from requirements.txt

### Architecture
The GUI is built using:
- **tkinter** - Main GUI framework
- **task_manager.py** - Backend task management
- **config.py** - Task definitions and configuration

### Files
- `psychology_client_gui.py` - Main GUI application
- `run_gui.bat` - Windows launcher
- `run_gui.sh` - Linux/Mac launcher
- `GUI_README.md` - This documentation

## 📊 Data Management

### Automatic Backups
Before each task launch, the GUI automatically creates a backup of existing data:
- Location: `data_backup/` folder
- Format: `{task}_{database}_{YYYYMMDD_HHMMSS}`
- Includes both .mdb databases and .txt output files

### Data Export
Use the Export Data button to copy all task data to the output folder:
- Location: `data_output/` folder
- Includes all database files (.mdb)
- Includes all text output files (.txt)

## 🎯 Usage Tips

1. **First Time Setup**
   - Check the System tab to verify all requirements
   - Ensure all tasks show "✓ Ready" status
   - Install Wine if using Linux/Mac

2. **Launching Tasks**
   - Click "Launch Task" on any available task card
   - Confirm the launch in the dialog
   - A backup is created automatically
   - Task opens in a new window

3. **Managing Data**
   - Backups are created automatically - no manual backup needed
   - Use Export Data to collect all data in one location
   - Open folders directly from the Data tab

4. **Getting Help**
   - Check the Help tab for detailed documentation
   - System tab shows what's working/missing
   - Footer shows current status

## 🐛 Troubleshooting

### GUI won't launch
- Ensure Python 3.7+ is installed: `python3 --version`
- Check that tkinter is available: `python3 -c "import tkinter"`
- Try running directly: `python3 psychology_client_gui.py`

### Tasks show "Not Found"
- Verify task executable files exist in their directories
- Check System tab for detailed availability
- Ensure task folders contain the .exe files

### Launch fails on Linux/Mac
- Verify Wine is installed: `wine --version`
- Install Wine if needed: [WineHQ](https://www.winehq.org/)
- Minimum Wine version: 5.0+

## 🎨 Color Scheme

The GUI uses a professional color palette:
- **Primary**: Blue (#4A90E2) - Buttons and accents
- **Dark**: Charcoal (#2C3E50) - Header background
- **Light**: Cloud (#ECF0F1) - Background
- **Success**: Green (#27AE60) - Available tasks
- **Warning**: Red (#E74C3C) - Missing tasks
- **Categories**: Purple, Red, Blue - Task categories

## 📝 Notes

- The GUI is designed to be professional yet approachable
- All existing CLI functionality is preserved
- Use `psychology_client.py` for command-line interface
- Use `psychology_client_gui.py` for graphical interface
- Both interfaces use the same backend

## 🎉 Enjoy!

The CAPER Suite GUI makes psychology research task management simple and enjoyable. Launch tasks, manage data, and monitor system status - all from a beautiful, modern interface!

---

**Version**: 2.0
**License**: Psychology Research Tools
**Maintained by**: CAPER Suite Team
