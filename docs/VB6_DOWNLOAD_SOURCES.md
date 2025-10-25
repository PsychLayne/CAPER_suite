# VB6 Runtime Download URLs

This file contains backup download URLs for VB6 Runtime SP6 in case Microsoft's links change.

## Official Microsoft Sources

**Primary:** Microsoft Download Center (requires browser)
- https://www.microsoft.com/en-us/download/details.aspx?id=24417

**Direct Downloads** (links may change):
- https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VBRun60sp6.exe
- https://download.microsoft.com/download/vb60sp6/Update/6/W9XNT4/EN-US/VBRun60sp6.exe

## Alternative Sources

**Archive.org** (Community maintained backup):
- https://archive.org/details/vbrun60sp6
- Direct: https://ia801609.us.archive.org/10/items/vbrun60sp6/VBRun60sp6.exe

## File Information

- **Filename:** VBRun60sp6.exe
- **Size:** ~1.4 MB (1,445,888 bytes)
- **Description:** Microsoft Visual Basic 6.0 Service Pack 6 Runtime
- **Publisher:** Microsoft Corporation
- **Safe:** Yes - official Microsoft runtime library

## SHA256 Hash (for verification)

If you download manually, verify the file integrity:
```
VBRun60sp6.exe
SHA256: (varies by source, check with official Microsoft documentation)
```

## Updating Download URLs

If Microsoft changes their download links again, you can:

### Method 1: Update this file
1. Find a working download URL
2. Add it to this file
3. Update `setup.py` line ~192 in the `download_urls` list

### Method 2: Use manual download
1. Download VBRun60sp6.exe from any trusted source
2. Run as Administrator: VBRun60sp6.exe
3. Or use: scripts\install_vb6_runtime.bat

### Method 3: Provide custom URL
You can modify `setup.py` to use a custom URL:
- Edit line ~192: `download_urls = [...]`
- Add your URL to the list
- Run: python setup.py

## Troubleshooting

**Q: Download fails from all sources?**
A: Download manually from Microsoft Download Center or Archive.org, then run the installer yourself.

**Q: How do I know if it's the right file?**
A: Check file size (~1.4 MB) and run virus scan. Official Microsoft file is safe.

**Q: Can I host this file myself?**
A: Yes, but check Microsoft's redistribution license. For personal/research use, downloading from official sources is recommended.

## Last Verified

- **Date:** 2025-01-XX
- **Status:** Microsoft links may require browser download
- **Working Alternative:** Archive.org maintains backups

---

For more information, see:
- docs/FIX_VB6_RUNTIME.md
- TROUBLESHOOTING.md
