# CAPER Suite Utility Scripts

This folder contains utility scripts for system setup and diagnostics.

## Batch Files (Windows - Double-click to run):

### VB6 Runtime Management
- **install_vb6_runtime.bat** - Install Visual Basic 6.0 Runtime SP6 (Run as Administrator!)
- **check_vb6_dependencies.bat** - Check if VB6 runtime DLLs are installed

### Windows Security
- **add_windows_defender_exclusion.ps1** - Add CAPER Suite to Windows Defender exclusions

## Python Scripts (Can be called by batch files or directly):

- **install_vb6_runtime.py** - Python script for VB6 runtime installation
- **check_vb6_dependencies.py** - Python script to verify VB6 DLLs

---

## Usage

### From Windows Explorer:
1. **Right-click** `install_vb6_runtime.bat`
2. Select **"Run as Administrator"**
3. Follow on-screen instructions

### From Command Prompt:
```cmd
cd path\to\CAPER_suite
scripts\install_vb6_runtime.bat
```

### Directly with Python:
```cmd
python scripts\check_vb6_dependencies.py
python scripts\install_vb6_runtime.py
```

---

**Note:** These scripts are automatically called by the main setup process (`setup.py`), but are available here for manual troubleshooting.

Return to: [Main README](../README.md) | [Troubleshooting](../TROUBLESHOOTING.md)
