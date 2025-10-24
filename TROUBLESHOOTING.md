# CAPER Suite Troubleshooting Guide

Quick solutions to common problems.

---

## 🔍 Quick Problem Finder

**Select your issue:**

- [Error: "System Error &H8007007E - Module not found"](#error-module-not-found)
- [Error: "Python was not found"](#error-python-not-found)
- [Windows Defender blocking tasks](#windows-defender-blocking-tasks)
- [UI won't launch](#ui-wont-launch)
- [Task executable not found](#task-executable-not-found)

---

## Error: Module Not Found

**Symptoms:**
```
System Error &H8007007E (-2147024770)
The specified module could not be found.
```

**Cause:** VB6 runtime libraries are missing from Windows.

**Solution:**

### Option 1: One-Click Setup (Easiest)
1. Right-click `setup.bat` and select "Run as Administrator"
2. Press Enter to begin
3. Type `y` when prompted to install VB6 Runtime
4. Wait for automatic download and installation (~1.4 MB)
5. Restart your computer
6. Test a task

### Option 2: Automated Script
1. Right-click and "Run as Administrator": `scripts/install_vb6_runtime.bat`
2. Follow the on-screen instructions
3. Restart your computer
4. Test a task

### Option 2: Manual Installation
1. Download [VB6 Runtime SP6](https://www.microsoft.com/en-us/download/details.aspx?id=24417)
2. Right-click `VBRun60sp6.exe` → "Run as Administrator"
3. Follow installation wizard
4. Restart your computer
5. Test a task

**Verify the fix:**
```cmd
scripts\check_vb6_dependencies.bat
```

📖 **See:** `docs/FIX_VB6_RUNTIME.md` for detailed instructions

---

## Error: Python Not Found

**Symptoms:**
```
Python was not found; run without arguments to install from the Microsoft Store
```

**Cause:** Python is installed but not in your PATH environment variable.

**Solution:**

### Option 1: Add Python to PATH (Permanent Fix)
1. Press Windows key, type "environment"
2. Click "Edit the system environment variables"
3. Click "Environment Variables"
4. Under "User variables", find "Path" → "Edit"
5. Click "New"
6. Add your Python folder (e.g., `C:\Users\YourName\AppData\Local\Programs\Python\Python312`)
7. Add Scripts folder too: `C:\Users\YourName\AppData\Local\Programs\Python\Python312\Scripts`
8. Click OK on all windows
9. Restart Command Prompt

### Option 2: Use py Launcher (Quick Fix)
```cmd
py psychology_client.py
```

### Option 3: Reinstall Python
1. Download from [python.org](https://www.python.org/downloads/)
2. **CHECK "Add Python to PATH"** during installation ← CRITICAL!
3. Complete installation
4. Try again

📖 **See:** `docs/PYTHON_NOT_FOUND.md` for detailed instructions

---

## Windows Defender Blocking Tasks

**Symptoms:**
- Files deleted or quarantined by Windows Defender
- "Threat detected" messages
- Task executables missing

**Cause:** Windows Defender falsely identifies legacy VB6 programs as threats.

**Solution:**

### Quick Fix (Requires Administrator)
1. Right-click PowerShell → "Run as Administrator"
2. Navigate to CAPER_suite folder
3. Run: `.\scripts\add_windows_defender_exclusion.ps1`
4. Type 'Y' to confirm

### Manual Fix
1. Open Windows Security (Windows key + I)
2. Go to "Virus & threat protection"
3. Click "Manage settings"
4. Scroll to "Exclusions" → "Add or remove exclusions"
5. Add the entire CAPER_suite folder

**These files are safe!** They're legitimate research software used in academic settings worldwide.

📖 **See:** `docs/WINDOWS_DEFENDER_FALSE_POSITIVE.md` for more information

---

## UI Won't Launch

**Symptoms:**
- Double-clicking `run_gui.bat` does nothing
- Window closes immediately
- Error messages flash too quickly to read

**Solutions:**

### Check 1: Python Installation
Run from Command Prompt:
```cmd
python --version
```
If you see an error, see [Python Not Found](#error-python-not-found)

### Check 2: Install Requirements
```cmd
python -m pip install -r requirements.txt
```

### Check 3: Run from Command Prompt
```cmd
python psychology_client_gui.py
```
This will show you the actual error message.

### Check 4: Run Setup
```cmd
python setup.py
```
This checks all dependencies and system requirements.

---

## Task Executable Not Found

**Symptoms:**
- "Task executable not found" error
- Tasks show with ✗ instead of ✓

**Solutions:**

### Check 1: Verify Files Exist
Look in task folders (e.g., `PASAT/`, `BART_BAIT/`) for `.exe` files.

### Check 2: Restore from Quarantine
Windows Defender may have quarantined files:
1. Open Windows Security
2. Go to "Virus & threat protection"
3. Click "Protection history"
4. Find quarantined files
5. Click "Restore"

### Check 3: Re-download CAPER Suite
If files are missing:
1. Download fresh copy from GitHub
2. Extract to new location
3. Add Windows Defender exclusion BEFORE opening
4. Run setup

---

## Still Having Issues?

### Get System Information
```cmd
python psychology_client.py
```
Select "View System Info" to see your configuration.

### Check All Requirements
```cmd
python setup.py
```
This verifies Python, packages, and dependencies.

### Check VB6 Dependencies
```cmd
scripts\check_vb6_dependencies.bat
```
Shows which runtime DLLs are installed.

### Common Issues Checklist

- [ ] Python 3.7+ installed and in PATH
- [ ] Python packages installed (`pip install -r requirements.txt`)
- [ ] VB6 Runtime SP6 installed
- [ ] Windows Defender exclusion added
- [ ] Running with appropriate permissions
- [ ] Task executable files present

---

## For IT Administrators

### Deployment Checklist

1. **Pre-install VB6 Runtime SP6**
   ```cmd
   VBRun60sp6.exe /q
   ```

2. **Add Defender Exclusions via Group Policy**
   - Computer Configuration → Administrative Templates
   - Windows Components → Microsoft Defender Antivirus → Exclusions

3. **Install Python with PATH**
   ```cmd
   python-3.12.0-amd64.exe /quiet PrependPath=1
   ```

4. **Deploy CAPER Suite**
   - Copy to standard location (e.g., `C:\Program Files\CAPER_suite`)
   - Install requirements: `pip install -r requirements.txt`

5. **Test on pilot machine** before bulk deployment

📖 **See:** Main `README.md` for full deployment documentation

---

## Additional Resources

- **Main Documentation:** `README.md`
- **GUI Documentation:** `docs/GUI_README.md`
- **VB6 Runtime Fix:** `docs/FIX_VB6_RUNTIME.md`
- **Python PATH Fix:** `docs/PYTHON_NOT_FOUND.md`
- **Windows Defender:** `docs/WINDOWS_DEFENDER_FALSE_POSITIVE.md`

---

## Getting Help

1. Check this troubleshooting guide first
2. Read the detailed docs in `docs/` folder
3. Run system verification: `python setup.py`
4. Check GitHub issues for similar problems
5. Create new issue with system info and error messages

---

**Remember:** Most issues are solved by:
1. Installing VB6 Runtime SP6
2. Adding Python to PATH
3. Adding Windows Defender exclusion

These three steps fix 90% of problems!
