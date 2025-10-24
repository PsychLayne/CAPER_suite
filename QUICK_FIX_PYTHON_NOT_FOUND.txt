================================================================================
QUICK FIX: Python was not found
================================================================================

PROBLEM: When running batch files, you see:
         "Python was not found; run without arguments to install from
         the Microsoft Store, or disable this shortcut from Settings"

CAUSE:   Python is installed but not in your system PATH, so Windows
         can't find it.

================================================================================
SOLUTION 1: Add Python to PATH (Recommended - 2 minutes)
================================================================================

Step 1: Find your Python installation
  Common locations:
    - C:\Users\YourName\AppData\Local\Programs\Python\Python312
    - C:\Users\YourName\AppData\Local\Programs\Python\Python311
    - C:\Python312
    - C:\Program Files\Python312

  To find it:
    a. Press Windows key, type "python"
    b. Right-click Python in results, select "Open file location"
    c. Copy the folder path

Step 2: Add to PATH
  1. Press Windows key
  2. Type "environment" and press Enter
  3. Click "Edit the system environment variables"
  4. Click "Environment Variables" button (bottom right)
  5. Under "User variables" (top section):
     - Find "Path" variable
     - Click "Edit"
  6. Click "New"
  7. Paste your Python folder path (e.g., C:\Users\Layne\AppData\Local\Programs\Python\Python312)
  8. Click "New" again
  9. Add the Scripts folder too (add \Scripts to the path)
     (e.g., C:\Users\Layne\AppData\Local\Programs\Python\Python312\Scripts)
  10. Click OK on all windows

Step 3: Restart
  1. Close ALL Command Prompt and PowerShell windows
  2. Close the CAPER Suite if it's open
  3. Reopen Command Prompt
  4. Test: type "python --version" - should show Python version

Step 4: Try again
  Double-click the batch file again. It should work now!

================================================================================
SOLUTION 2: Use py Launcher (Quick alternative)
================================================================================

Windows includes a "py" launcher that should work even if Python isn't in PATH.

Try this in Command Prompt:
  1. Open Command Prompt as Administrator
  2. Navigate to CAPER folder: cd /d "C:\path\to\CAPER_suite"
  3. Run: py install_vb6_runtime.py

This should work without modifying PATH.

================================================================================
SOLUTION 3: Reinstall Python with PATH (Clean slate - 5 minutes)
================================================================================

If adding to PATH doesn't work, reinstall Python properly:

Step 1: Uninstall Python (optional but recommended)
  1. Press Windows key
  2. Type "Add or remove programs"
  3. Find "Python 3.x"
  4. Click Uninstall

Step 2: Download Python
  1. Go to: https://www.python.org/downloads/
  2. Click "Download Python 3.x" (get latest version)
  3. Save the installer

Step 3: Install Python CORRECTLY
  *** IMPORTANT ***
  1. Run the Python installer
  2. CHECK THE BOX: "Add Python to PATH" ← DO NOT SKIP THIS!
  3. Click "Install Now"
  4. Wait for installation to complete
  5. Click "Close"

Step 4: Verify
  1. Open Command Prompt
  2. Type: python --version
  3. Should show: Python 3.12.x (or your version)

Step 5: Try CAPER Suite again
  Double-click the batch file. Should work now!

================================================================================
SOLUTION 4: Skip Python - Install VB6 Runtime Manually (Fastest - 3 minutes)
================================================================================

You can skip the Python scripts and install VB6 Runtime directly:

Step 1: Download VB6 Runtime
  Go to: https://www.microsoft.com/en-us/download/details.aspx?id=24417
  Click "Download"
  Save: VBRun60sp6.exe

Step 2: Install
  1. Right-click VBRun60sp6.exe
  2. Select "Run as Administrator"
  3. Click "Yes" if prompted
  4. Follow the installation wizard
  5. Click "OK" when complete

Step 3: Restart computer (recommended)

Step 4: Test
  Launch CAPER Suite and try running a task
  Should work now!

================================================================================
TROUBLESHOOTING
================================================================================

Issue: "Access Denied" when editing PATH
Solution:
  - Make sure you're editing "User variables" not "System variables"
  - Or run as Administrator

Issue: "Python 3.12 was not found" after adding to PATH
Solution:
  - Did you close and reopen Command Prompt?
  - Restart your computer
  - Verify the path you added is correct (no typos)

Issue: Multiple Python versions installed
Solution:
  - Uninstall all Python versions
  - Reinstall just one version with "Add to PATH" checked
  - Cleaner and easier to manage

Issue: Microsoft Store Python keeps interfering
Solution:
  1. Go to Settings > Apps > Advanced app settings > App execution aliases
  2. Turn OFF "App Installer" aliases for python.exe and python3.exe
  3. Then add your real Python to PATH

================================================================================
VERIFICATION
================================================================================

After fixing, verify Python is working:

Test 1: Command Prompt
  Open Command Prompt and type:
    python --version
  Should show: Python 3.x.x

Test 2: Batch File
  Double-click: check_vb6_dependencies.bat
  Should run without errors

Test 3: VB6 Installer
  Right-click and "Run as Administrator": install_vb6_runtime.bat
  Should launch the installer

================================================================================
STILL STUCK?
================================================================================

If none of these work, you have two options:

Option A: Manual VB6 Installation (skip Python completely)
  - See SOLUTION 4 above
  - Install VB6 Runtime directly from Microsoft
  - No Python needed for this step

Option B: Get Help
  - Check README.md for more information
  - Make sure you downloaded the correct CAPER Suite files
  - Verify you're running Windows (not Linux/Mac with WSL)

================================================================================
FOR DEVELOPERS/IT STAFF
================================================================================

If deploying to multiple machines:

1. Pre-install Python with PATH:
   msiexec /i python-3.12.0-amd64.exe /quiet PrependPath=1

2. Pre-install VB6 Runtime:
   VBRun60sp6.exe /q

3. Deploy CAPER Suite to standard location:
   C:\Program Files\CAPER_suite

4. Test on one machine before bulk deployment

================================================================================
