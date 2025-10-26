# How to Update CAPER Suite

You're seeing errors because you need to pull the latest changes from the repository. Here's how:

## Quick Update (Easiest)

**Double-click:** `update.bat`

This will automatically pull the latest version.

## Manual Update

Open Command Prompt or Git Bash in the CAPER_suite folder:

```bash
git pull origin claude/remake-cli-interface-011CUW2fmm36R36VbXE5Y9uW
```

## What's Been Fixed

### Issue #1: Path Resolution ✅
**Fixed in commit:** e0c5098

The `run_gui.bat` file now changes to its own directory before running Python scripts, so it works no matter where you run it from (Desktop, File Explorer, etc.).

**Before:**
```batch
@echo off
echo Launching...
py src\launch_gui_1024.py    # ❌ Fails if run from System32
```

**After:**
```batch
@echo off
cd /d "%~dp0"                 # ✅ Change to batch file's directory first
echo Launching...
py src\launch_gui_1024.py
```

### Issue #2: Resolution Restoration ✅
**Fixed in commit:** [current]

The resolution now ALWAYS restores, even if:
- The GUI crashes
- You close it with X button
- You press ESC
- Any error occurs

**How it works:**
- Uses Python's `atexit` module
- Registers restoration function to run on exit
- Guaranteed to execute when Python exits
- Extra error handling for robustness

## Verify the Update Worked

After updating, check that `run_gui.bat` starts with:

```batch
@echo off
REM CAPER Suite - GUI Launcher for Windows

REM Change to the directory where this batch file is located
cd /d "%~dp0"
```

If you see `cd /d "%~dp0"` on line 5, you have the correct version!

## Troubleshooting

### "Git is not recognized"

You don't have Git installed. Either:

1. **Install Git:** https://git-scm.com/download/win
2. **Or download manually:**
   - Go to GitHub repository
   - Click "Code" → "Download ZIP"
   - Extract and replace your CAPER_suite folder

### "Already up to date" but still getting errors

Your local branch might be different. Try:

```bash
git status
git fetch origin
git reset --hard origin/claude/remake-cli-interface-011CUW2fmm36R36VbXE5Y9uW
```

⚠️ **Warning:** This will discard any local changes!

### Still having issues?

Run `test_gui.bat` to see detailed error messages, then share them for help.

## After Updating

Run `run_gui.bat` again - it should now:
1. ✅ Launch correctly from any location
2. ✅ Change resolution to 1024x768
3. ✅ Show the retro GUI
4. ✅ Restore resolution when you close it
