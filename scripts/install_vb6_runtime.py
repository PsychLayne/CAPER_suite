"""
VB6 Runtime Installer for CAPER Suite
Downloads and installs Visual Basic 6.0 Runtime SP6
"""

import os
import sys
import platform
import urllib.request
import tempfile
import subprocess
from pathlib import Path


def is_windows():
    """Check if running on Windows"""
    return platform.system() == "Windows"


def is_admin():
    """Check if running with administrator privileges"""
    try:
        import ctypes
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False


def download_file(url, dest_path, description="file"):
    """Download a file with progress indication"""
    try:
        print(f"\nDownloading {description}...")
        print(f"URL: {url}")
        print(f"Destination: {dest_path}")
        print("\nThis may take a few minutes depending on your connection speed...")

        def reporthook(count, block_size, total_size):
            if total_size > 0:
                percent = int(count * block_size * 100 / total_size)
                sys.stdout.write(f"\rProgress: {percent}% ")
                sys.stdout.flush()

        urllib.request.urlretrieve(url, dest_path, reporthook)
        print("\n✓ Download complete!")
        return True
    except Exception as e:
        print(f"\n✗ Download failed: {e}")
        return False


def install_vb6_runtime():
    """Install VB6 Runtime SP6"""
    if not is_windows():
        print("\n" + "=" * 80)
        print("VB6 RUNTIME INSTALLER - NON-WINDOWS SYSTEM")
        print("=" * 80)
        print("\nThis installer is for Windows only.")
        print("On Linux/Mac, Wine provides compatible VB6 runtime libraries.")
        print("\nIf you're experiencing issues with Wine:")
        print("  1. Ensure Wine is installed: wine --version")
        print("  2. Update Wine to the latest version")
        print("  3. Configure Wine: winecfg")
        print("\n" + "=" * 80)
        return False

    print("\n" + "=" * 80)
    print("VB6 RUNTIME SP6 INSTALLER FOR CAPER SUITE")
    print("=" * 80)

    # Check administrator privileges
    if not is_admin():
        print("\n⚠ WARNING: Not running as Administrator")
        print("\nThis installer requires administrator privileges to install system DLLs.")
        print("\nPlease:")
        print("  1. Right-click Command Prompt or PowerShell")
        print("  2. Select 'Run as Administrator'")
        print("  3. Navigate to the CAPER_suite directory")
        print("  4. Run: python install_vb6_runtime.py")
        print("\n" + "=" * 80)
        return False

    print("\n✓ Running with administrator privileges")

    # VB6 Runtime download options
    print("\n" + "=" * 80)
    print("INSTALLATION OPTIONS")
    print("=" * 80)

    print("\nOption 1: Microsoft Official (Recommended)")
    print("-" * 80)
    print("Download from Microsoft Download Center:")
    print("  URL: https://www.microsoft.com/en-us/download/details.aspx?id=24417")
    print("  File: VBRun60sp6.exe")
    print("  Size: ~1.4 MB")
    print("  Note: This link may require manual download via browser")

    print("\nOption 2: Manual Installation")
    print("-" * 80)
    print("If automatic download fails:")
    print("  1. Visit: https://www.microsoft.com/en-us/download/details.aspx?id=24417")
    print("  2. Click 'Download'")
    print("  3. Save VBRun60sp6.exe to this folder")
    print("  4. Run: VBRun60sp6.exe")

    print("\n" + "=" * 80)

    # Ask user which method they want to use
    print("\nHow would you like to proceed?")
    print("  1. Try automatic download from Microsoft (may not work)")
    print("  2. Open browser to Microsoft download page (recommended)")
    print("  3. I already downloaded VBRun60sp6.exe (install it now)")
    print("  4. Cancel")

    choice = input("\nEnter choice (1-4): ").strip()

    if choice == "1":
        # Try automatic download
        print("\n" + "=" * 80)
        print("AUTOMATIC DOWNLOAD")
        print("=" * 80)

        # Microsoft's direct download link (may not work due to redirects)
        url = "https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VBRun60sp6.exe"

        temp_dir = tempfile.gettempdir()
        installer_path = os.path.join(temp_dir, "VBRun60sp6.exe")

        if download_file(url, installer_path, "VB6 Runtime SP6"):
            print("\nRunning installer...")
            try:
                # Run the installer
                subprocess.run([installer_path], check=True)
                print("\n✓ Installation complete!")
                print("\nPlease run check_vb6_dependencies.py to verify installation.")
                return True
            except Exception as e:
                print(f"\n✗ Installation failed: {e}")
                print("\nThe installer file is located at:")
                print(f"  {installer_path}")
                print("\nYou can try running it manually.")
                return False
        else:
            print("\n✗ Automatic download failed.")
            print("\nPlease use Option 2 (manual download) instead.")
            return False

    elif choice == "2":
        # Open browser to download page
        print("\n" + "=" * 80)
        print("OPENING BROWSER")
        print("=" * 80)
        print("\nOpening Microsoft download page in your browser...")

        url = "https://www.microsoft.com/en-us/download/details.aspx?id=24417"

        try:
            import webbrowser
            webbrowser.open(url)
            print("✓ Browser opened")
        except:
            print(f"✗ Could not open browser automatically")
            print(f"\nPlease manually visit: {url}")

        print("\nNext steps:")
        print("  1. Download VBRun60sp6.exe from the Microsoft page")
        print("  2. Run VBRun60sp6.exe")
        print("  3. Follow the installation wizard")
        print("  4. Run: python check_vb6_dependencies.py")
        print("\n" + "=" * 80)
        return False

    elif choice == "3":
        # Install from current directory
        print("\n" + "=" * 80)
        print("INSTALLING FROM LOCAL FILE")
        print("=" * 80)

        base_dir = Path(__file__).parent
        installer_path = base_dir / "VBRun60sp6.exe"

        if not installer_path.exists():
            print(f"\n✗ File not found: {installer_path}")
            print("\nPlease ensure VBRun60sp6.exe is in the CAPER_suite directory.")
            return False

        print(f"\nFound installer: {installer_path}")
        print("Running installer...")

        try:
            subprocess.run([str(installer_path)], check=True)
            print("\n✓ Installation complete!")
            print("\nPlease run check_vb6_dependencies.py to verify installation.")
            return True
        except Exception as e:
            print(f"\n✗ Installation failed: {e}")
            return False

    else:
        print("\nInstallation cancelled.")
        return False


def main():
    """Main function"""
    try:
        print("\n" + "=" * 80)
        print("VISUAL BASIC 6.0 RUNTIME INSTALLER")
        print("=" * 80)
        print("\nThis script helps install VB6 Runtime SP6, which is required")
        print("to run the CAPER Suite psychology tasks.")
        print("\nThe error you're seeing:")
        print('  "System Error &H8007007E (-2147024770)"')
        print('  "The specified module could not be found."')
        print("\n...occurs when VB6 runtime DLLs are missing from your system.")
        print("\n" + "=" * 80)

        input("\nPress Enter to continue...")

        success = install_vb6_runtime()

        print("\n" + "=" * 80)
        if success:
            print("Installation process completed!")
            print("=" * 80)
            input("\nPress Enter to exit...")
            sys.exit(0)
        else:
            print("Installation not completed")
            print("=" * 80)
            print("\nPlease follow the instructions above.")
            input("\nPress Enter to exit...")
            sys.exit(1)

    except KeyboardInterrupt:
        print("\n\nInstallation cancelled by user.")
        input("\nPress Enter to exit...")
        sys.exit(1)
    except Exception as e:
        print("\n" + "=" * 80)
        print("ERROR OCCURRED")
        print("=" * 80)
        print(f"\nError: {e}")
        import traceback
        traceback.print_exc()
        print("\n" + "=" * 80)
        input("\nPress Enter to exit...")
        sys.exit(1)


if __name__ == "__main__":
    main()
