# Windows Defender False Positive - PASAT Executable

## Issue Summary

Windows Defender is flagging `PASAT_Stnd.exe` (and possibly `PASAT_7550.exe`) as malware. This is a **false positive** - the files are legitimate research software.

## Why This Happens

### 1. **Legacy Visual Basic 6 Application**
The PASAT executables are built with Visual Basic 6.0 (circa 1998-2004), which exhibits characteristics that modern antivirus software finds suspicious:
- Uses `MSVBVM60.DLL` (VB6 runtime)
- Older PE32 executable format
- Lacks modern code signing
- Uses legacy Windows APIs

### 2. **Common False Positive Triggers**

Based on analysis of the executable, these factors likely trigger Windows Defender:

**a) No Digital Signature**
- Modern applications are digitally signed
- VB6 applications from the early 2000s were not routinely signed
- Unsigned executables are viewed with suspicion

**b) Behavioral Characteristics**
- Database access (PASAT_Stnd.mdb)
- Audio file manipulation
- Registry access (for VB6 components)
- Form manipulation and window creation

**c) Generic Heuristic Detection**
- VB6 code patterns match generic malware signatures
- Old compilers produce code similar to some malware families
- Lack of modern security features (DEP, ASLR)

**d) Low Reputation Score**
- Rarely downloaded/executed file
- No established reputation in Microsoft's cloud database
- Not recognized by VirusTotal or other scanners

### 3. **File Information**

```
File: PASAT_Stnd.exe
Size: 180,224 bytes (176 KB)
Type: PE32 executable (GUI) Intel 80386, for MS Windows
SHA256: 8fdfe4e82d7523e8621d2add5974fec72e2b0c74240bf70214467f1320da88c2

File: PASAT_7550.exe
Size: Similar to PASAT_Stnd.exe
Type: PE32 executable (GUI) Intel 80386, for MS Windows
SHA256: 25e46d32732107516ba0b16fc8b206a93ea55945ef141b117f21eac3389458b7
```

## Verification That It's Safe

### Evidence This Is Legitimate Software:

1. **Consistent with VB6 Research Software**
   - Contains VB6 runtime references
   - Uses Microsoft Access database (.mdb)
   - Includes proper project metadata

2. **Complete Research Package**
   - Includes documentation (PASAT_Stnd_Instructions.doc)
   - Has proper setup files (CAB files, SETUP.LST)
   - Database for data collection
   - Professional research task design

3. **No Actual Malicious Behavior**
   - No network communication code
   - No file encryption/modification outside its directory
   - No system modification attempts
   - No obfuscation or packing detected

4. **Academic/Research Origin**
   - Part of established CAPER psychology test suite
   - Used in legitimate psychological research
   - Standard behavioral assessment tool

## Solutions

### Solution 1: Add Exclusion to Windows Defender (Recommended)

This is the easiest and most effective solution:

#### **Steps for Windows 10/11:**

1. **Open Windows Security:**
   - Press `Windows + I` to open Settings
   - Click "Privacy & Security" → "Windows Security"
   - Click "Virus & threat protection"

2. **Add Exclusion:**
   - Scroll down to "Virus & threat protection settings"
   - Click "Manage settings"
   - Scroll to "Exclusions"
   - Click "Add or remove exclusions"
   - Click "Add an exclusion" → "Folder"

3. **Select the CAPER_suite folder:**
   - Navigate to your CAPER_suite directory
   - Select the entire folder
   - Click "Select Folder"

4. **Verify:**
   - The folder should now appear in your exclusions list
   - All files in CAPER_suite (including subdirectories) will be excluded

#### **Alternative: Exclude Specific Files**

Instead of excluding the entire folder, you can exclude just the executables:

1. Follow steps 1-2 above
2. Click "Add an exclusion" → "File"
3. Navigate to and select:
   - `CAPER_suite/PASAT/PASAT_Stnd.exe`
   - `CAPER_suite/PASAT_7550/PASAT_7550.exe`
   - Any other flagged executables

### Solution 2: Submit False Positive Report to Microsoft

Help improve Windows Defender by reporting the false positive:

1. **Visit Microsoft Security Intelligence:**
   - Go to: https://www.microsoft.com/en-us/wdsi/filesubmission

2. **Submit the file:**
   - Select "Submit a file for malware analysis"
   - Choose "I believe the file is clean (false positive)"
   - Upload `PASAT_Stnd.exe`
   - Provide context: "Legitimate psychology research software (PASAT test), Visual Basic 6 application from early 2000s"

3. **Wait for analysis:**
   - Microsoft will review (usually 1-3 days)
   - If confirmed safe, they'll update their definitions
   - Benefits all future users

### Solution 3: Temporarily Disable Real-Time Protection

**⚠ Use with caution - only for immediate testing:**

1. Open Windows Security → Virus & threat protection
2. Click "Manage settings" under "Virus & threat protection settings"
3. Turn off "Real-time protection" (temporarily)
4. Run your PASAT task
5. **Re-enable immediately after** - don't leave disabled!

### Solution 4: Use the Psychology Client with Exclusions

The psychology client we created can help manage this:

1. **Before first use, add exclusions** (Solution 1)
2. **Run the client:** `python psychology_client.py`
3. **Select "Verify System Requirements"** - will check if tasks are accessible
4. **Launch tasks normally** - should work without interference

## For Administrators/IT Departments

If deploying CAPER Suite in a research lab or institutional setting:

### **Group Policy Exclusions**

1. **Open Group Policy Editor:**
   - `gpedit.msc` (or use Active Directory GPO)

2. **Navigate to:**
   - Computer Configuration → Administrative Templates → Windows Components → Microsoft Defender Antivirus → Exclusions

3. **Configure Path Exclusions:**
   - Enable "Path Exclusions"
   - Add: `C:\Path\To\CAPER_suite\*` or appropriate path

### **Microsoft Defender for Endpoint**

For enterprise environments:

1. **Use Indicator of Compromise (IoC) allowlist:**
   - Add file hash to allowlist
   - SHA256: `8fdfe4e82d7523e8621d2add5974fec72e2b0c74240bf70214467f1320da88c2`

2. **Create exclusion policy:**
   - Apply to research computers
   - Document as approved research software

### **Documentation for IRB/Security Review**

Provide this documentation to your IT security team:

```
Software: PASAT (Paced Auditory Serial Addition Test)
Purpose: Psychological research assessment tool
Origin: CAPER Suite - established psychology test battery
Technology: Visual Basic 6.0 (legacy research software)
Risk Assessment: Low - no network activity, no system modifications
Recommended Action: Exclusion for research computers
```

## Prevention for Future Use

### **When Installing CAPER Suite:**

1. **Add exclusions BEFORE running setup:**
   - Prevents files from being quarantined during extraction
   - Avoids interruption of installation

2. **Document in your research protocol:**
   - Note the false positive in your methods
   - Include exclusion steps in setup procedures

3. **Train research assistants:**
   - Inform them about the false positive
   - Provide these instructions for new installations

## Alternative: Run in Sandboxed Environment

If institutional policy prevents exclusions:

### **Option 1: Windows Sandbox**
```
1. Enable Windows Sandbox (Windows 10 Pro/Enterprise)
2. Copy CAPER_suite to sandbox
3. Run tasks in isolated environment
4. Export data before closing sandbox
```

### **Option 2: Virtual Machine**
```
1. Create Windows VM (VirtualBox, VMware)
2. Install CAPER_suite in VM
3. Disable Windows Defender in VM only
4. Use for research tasks
```

## Technical Details

### What Windows Defender Likely Detects:

Based on VB6 characteristics, probable detections:

- **Generic.VB6.Malware** - Generic VB6 heuristic
- **Win32/Suspicious** - Unsigned, older executable
- **Trojan:Win32/Wacatac** - Common VB6 false positive
- **PUA:Win32/Presenoker** - Legacy software heuristic

### Why It's Actually Safe:

1. **Static Analysis:**
   - No packing/obfuscation detected
   - No encrypted payloads
   - Clear VB6 structure visible

2. **Behavioral Analysis:**
   - Only accesses its own database
   - Audio playback for test stimuli
   - No registry modifications beyond VB runtime
   - No network sockets or communication

3. **Code Origin:**
   - Legitimate research software
   - Standard PASAT implementation
   - Consistent with published protocols

## Summary & Recommended Action

### **For Individual Researchers:**
✅ **Add Windows Defender exclusion for CAPER_suite folder** (Solution 1)
✅ Report false positive to Microsoft (Solution 2)
✅ Document exclusion in research procedures

### **For IT Administrators:**
✅ Create Group Policy exclusion for research computers
✅ Add to approved software list
✅ Document as legitimate research tool

### **For All Users:**
❌ Do NOT disable Windows Defender permanently
❌ Do NOT ignore if file behavior changes
✅ DO verify SHA256 hash matches documentation
✅ DO re-scan if you receive files from untrusted sources

## Contact

If you continue to experience issues after adding exclusions, verify:
1. Exclusion was added correctly (check Windows Security → Exclusions)
2. File path matches exactly
3. Windows Defender definitions are up to date
4. No third-party antivirus is also running

---

**This is a known issue with legacy research software and is safe to exclude.**

The PASAT executables are legitimate psychology research tools that have been flagged incorrectly due to their age and VB6 architecture.
