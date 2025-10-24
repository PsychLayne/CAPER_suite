# How to Fix "System Error &H8007007E - Module Not Found"

## Quick Fix Guide

If you're seeing this error when trying to run a task:
```
System Error &H8007007E (-2147024770)
The specified module could not be found.
```

**This means Visual Basic 6.0 runtime libraries are missing from your Windows system.**

---

## Solution (3 Easy Steps)

### Step 1: Check What's Missing

**Double-click this file:**
```
check_vb6_dependencies.bat
```

This will show you which VB6 DLLs are missing.

---

### Step 2: Install VB6 Runtime

**Right-click this file and select "Run as Administrator":**
```
install_vb6_runtime.bat
```

**IMPORTANT:** You MUST run as Administrator!

The installer will:
1. Check if you have administrator privileges
2. Give you options to download VB6 Runtime SP6
3. Guide you through the installation process

---

### Step 3: Verify the Fix

**Double-click this file again:**
```
check_vb6_dependencies.bat
```

You should now see ✓ checkmarks next to all required DLLs.

---

## Alternative: Command Line Method

If the batch files don't work, you can run the Python scripts directly:

1. **Open Command Prompt as Administrator**
   - Press Windows key
   - Type "cmd"
   - Right-click "Command Prompt"
   - Select "Run as Administrator"

2. **Navigate to CAPER_suite folder**
   ```cmd
   cd C:\path\to\CAPER_suite
   ```

3. **Check dependencies**
   ```cmd
   python check_vb6_dependencies.py
   ```

4. **Install VB6 runtime**
   ```cmd
   python install_vb6_runtime.py
   ```

5. **Verify installation**
   ```cmd
   python check_vb6_dependencies.py
   ```

---

## Manual Installation

If the automatic installer doesn't work:

1. **Download VB6 Runtime SP6 from Microsoft:**
   - Go to: https://www.microsoft.com/en-us/download/details.aspx?id=24417
   - Click "Download"
   - Save `VBRun60sp6.exe`

2. **Run the installer:**
   - Right-click `VBRun60sp6.exe`
   - Select "Run as Administrator"
   - Follow the installation wizard

3. **Restart your computer** (recommended)

4. **Run the dependency checker to verify:**
   ```
   check_vb6_dependencies.bat
   ```

---

## What DLLs Are Required?

The CAPER Suite tasks need these VB6 runtime files:

### Core Runtime:
- `msvbvm60.dll` - Visual Basic 6.0 Runtime Library
- `oleaut32.dll` - OLE Automation
- `olepro32.dll` - OLE Property Support
- `asycfilt.dll` - Asynchronous Filter
- `comcat.dll` - Component Categories Manager

### Database Support:
- `dao350.dll` - Data Access Objects
- `msjet35.dll` - Microsoft Jet Database Engine
- Various other Jet-related DLLs

### Common Controls:
- `mscomctl.ocx` - Windows Common Controls
- `mscomct2.ocx` - Common Controls 2
- `comdlg32.ocx` - Common Dialog Control
- Various other OCX controls

**The VB6 Runtime SP6 installer provides all of these automatically.**

---

## Troubleshooting

### Problem: "Not running as Administrator"

**Solution:**
- Right-click the batch file or Command Prompt
- Select "Run as Administrator"
- Run the installer again

---

### Problem: "The window closes immediately"

**Solution:**
Use the batch files instead of Python files directly:
- Use `install_vb6_runtime.bat` (keeps window open)
- Use `check_vb6_dependencies.bat` (keeps window open)

---

### Problem: "Python is not recognized"

**Solution:**
Python is not in your PATH. Either:
- Reinstall Python and check "Add Python to PATH"
- Or use full path: `C:\Python39\python.exe install_vb6_runtime.py`

---

### Problem: "Download failed"

**Solution:**
Use Option 2 in the installer:
- Opens browser to Microsoft download page
- Download VBRun60sp6.exe manually
- Run it directly (as Administrator)

---

### Problem: "Still getting the error after installing"

**Solutions to try:**

1. **Restart your computer**
   - Some DLLs require a reboot to register

2. **Run the dependency checker**
   ```
   check_vb6_dependencies.bat
   ```
   - Verify ALL DLLs show ✓

3. **Check Windows Defender**
   - See `QUICK_FIX_WINDOWS_DEFENDER.txt`
   - Windows Defender may be blocking executables

4. **Reinstall VB6 Runtime**
   - Download VBRun60sp6.exe again
   - Run as Administrator
   - Restart computer

---

## For IT Administrators

Deploying CAPER Suite to multiple computers:

1. **Pre-install VB6 Runtime SP6** on all machines using Group Policy
2. **Add Windows Defender exclusions** for CAPER_suite folder
3. **Test on one machine first** before deployment
4. **Include VBRun60sp6.exe** in your deployment package

---

## Still Need Help?

1. Check `QUICK_FIX_MODULE_NOT_FOUND.txt` for more details
2. Check `QUICK_FIX_WINDOWS_DEFENDER.txt` for security issues
3. See `README.md` for general documentation
4. Open an issue on GitHub if problems persist

---

## Why Is This Needed?

The CAPER Suite psychology tasks were built with Visual Basic 6.0 in the early 2000s. Modern Windows (Windows 10/11) doesn't include VB6 runtime libraries by default. This is a one-time installation that provides backward compatibility with legacy VB6 applications.

After installing VB6 Runtime SP6, all tasks should work normally.
