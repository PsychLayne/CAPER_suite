"""
VB6 Dependency Checker for CAPER Suite
Checks if required Visual Basic 6.0 runtime dependencies are installed
"""

import os
import platform
import sys
from pathlib import Path
import ctypes

# Required DLLs for VB6 applications
REQUIRED_DLLS = {
    # Core VB6 Runtime
    "msvbvm60.dll": "Visual Basic 6.0 Runtime Library",

    # OLE/COM Libraries
    "oleaut32.dll": "OLE Automation",
    "olepro32.dll": "OLE Property Support",
    "asycfilt.dll": "Asynchronous Filter",
    "comcat.dll": "Component Categories Manager",

    # Standard Runtime
    "msvcrt.dll": "Microsoft C Runtime",
    "msvcrt40.dll": "Microsoft C Runtime 4.0",

    # Database Support
    "dao350.dll": "Data Access Objects 3.5",
    "msjet35.dll": "Microsoft Jet Database Engine 3.5",
    "msjint35.dll": "Jet International Support",
    "msjter35.dll": "Jet Error Messages",
    "msrd2x35.dll": "Jet ISAM",
    "msrepl35.dll": "Jet Replication",
    "vbajet32.dll": "VBA Jet Support",
    "expsrv.dll": "Expression Service",

    # Common Controls (OCX files)
    "mscomctl.ocx": "Windows Common Controls",
    "mscomct2.ocx": "Common Controls 2",
    "msstdfmt.dll": "Standard Format",
    "mshflxgd.ocx": "Hierarchical FlexGrid",
    "msflxgrd.ocx": "FlexGrid Control",
    "msmask32.ocx": "Masked Edit Control",
    "comct332.ocx": "Common Controls 3",
    "mci32.ocx": "Multimedia Control",
    "comdlg32.ocx": "Common Dialog Control",
}

# Optional DLLs (used by some tasks)
OPTIONAL_DLLS = {
    "dlportio.dll": "Direct I/O Port Access (for BART tasks)",
    "vb5db.dll": "VB5 Database Support",
}


def is_windows():
    """Check if running on Windows"""
    return platform.system() == "Windows"


def find_dll_in_system(dll_name):
    """
    Try to find a DLL in Windows system directories
    Returns True if found, False otherwise
    """
    if not is_windows():
        return None

    # Common system paths
    system_paths = [
        os.path.join(os.environ.get('SystemRoot', 'C:\\Windows'), 'System32'),
        os.path.join(os.environ.get('SystemRoot', 'C:\\Windows'), 'SysWOW64'),
        os.path.join(os.environ.get('SystemRoot', 'C:\\Windows'), 'System'),
        os.path.join(os.environ.get('ProgramFiles', 'C:\\Program Files'), 'Common Files', 'Microsoft Shared'),
    ]

    for path in system_paths:
        dll_path = os.path.join(path, dll_name)
        if os.path.exists(dll_path):
            return dll_path

    # Try loading the DLL to see if Windows can find it
    try:
        # This will search the DLL search path
        handle = ctypes.windll.kernel32.LoadLibraryW(dll_name)
        if handle:
            ctypes.windll.kernel32.FreeLibrary(handle)
            return "Found in system PATH"
    except:
        pass

    return None


def check_dependencies():
    """Check all required dependencies"""
    if not is_windows():
        print("\n" + "=" * 80)
        print("VB6 DEPENDENCY CHECKER - NON-WINDOWS SYSTEM")
        print("=" * 80)
        print("\nYou are not running Windows.")
        print("VB6 applications require Wine to run on Linux/Mac.")
        print("\nWine should provide compatible runtime libraries automatically.")
        print("If you encounter issues, ensure Wine is properly installed:")
        print("  - Linux: sudo apt-get install wine (Ubuntu/Debian)")
        print("  - Mac: brew install wine-stable")
        print("\n" + "=" * 80)
        return True

    print("\n" + "=" * 80)
    print("VB6 DEPENDENCY CHECKER FOR CAPER SUITE")
    print("=" * 80)
    print("\nChecking required Visual Basic 6.0 runtime dependencies...\n")

    missing_required = []
    missing_optional = []
    found_count = 0

    # Check required DLLs
    print("Required Dependencies:")
    print("-" * 80)
    for dll, description in REQUIRED_DLLS.items():
        location = find_dll_in_system(dll)
        if location:
            print(f"  ✓ {dll:<20} - {description}")
            found_count += 1
        else:
            print(f"  ✗ {dll:<20} - {description} [MISSING]")
            missing_required.append((dll, description))

    # Check optional DLLs
    print("\nOptional Dependencies:")
    print("-" * 80)
    for dll, description in OPTIONAL_DLLS.items():
        location = find_dll_in_system(dll)
        if location:
            print(f"  ✓ {dll:<20} - {description}")
        else:
            print(f"  ⚠ {dll:<20} - {description} [MISSING - Some tasks may not work]")
            missing_optional.append((dll, description))

    # Summary
    print("\n" + "=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Required DLLs found: {found_count}/{len(REQUIRED_DLLS)}")

    if not missing_required:
        print("\n✓ All required dependencies are installed!")
        print("  Your system should be able to run CAPER Suite tasks.")
        if missing_optional:
            print("\n⚠ Some optional dependencies are missing.")
            print("  Most tasks will work, but some features may be unavailable.")
        print("\n" + "=" * 80)
        return True
    else:
        print(f"\n✗ {len(missing_required)} required dependencies are missing!")
        print("\nThis is likely causing the error:")
        print('  "System Error &H8007007E (-2147024770)"')
        print('  "The specified module could not be found."')

        print("\n" + "=" * 80)
        print("SOLUTION")
        print("=" * 80)
        print("\nTo fix this error, install the VB6 runtime package:\n")

        print("Option 1: Automatic Installation (Recommended)")
        print("-" * 80)
        print("Run the automatic installer script:")
        print("  python install_vb6_runtime.py")

        print("\nOption 2: Manual Installation")
        print("-" * 80)
        print("1. Download VB6 Runtime SP6:")
        print("   https://www.microsoft.com/en-us/download/details.aspx?id=24417")
        print("\n2. Run the installer: VBRun60sp6.exe")
        print("\n3. Re-run this check script to verify installation")

        print("\nOption 3: Alternative Runtime Package")
        print("-" * 80)
        print("Download from archive.org (if Microsoft link doesn't work):")
        print("   Search for 'VB6 Runtime SP6' or 'vbrun60sp6.exe'")

        print("\n" + "=" * 80)
        print("MISSING COMPONENTS")
        print("=" * 80)
        for dll, description in missing_required:
            print(f"  - {dll} ({description})")

        print("\n" + "=" * 80)
        return False


def main():
    """Main function"""
    try:
        all_present = check_dependencies()

        if all_present:
            input("\nPress Enter to exit...")
            sys.exit(0)
        else:
            print("\nAfter installing the VB6 runtime, run this script again to verify.")
            print("\n" + "=" * 80 + "\n")
            input("Press Enter to exit...")
            sys.exit(1)

    except Exception as e:
        print("\n" + "=" * 80)
        print("ERROR OCCURRED")
        print("=" * 80)
        print(f"\nError during dependency check: {e}")
        import traceback
        traceback.print_exc()
        print("\n" + "=" * 80)
        input("\nPress Enter to exit...")
        sys.exit(1)


if __name__ == "__main__":
    main()
