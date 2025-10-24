#!/usr/bin/env python3
"""
CAPER Suite Psychology Client - One-Click Setup Script
Automatic installation for all requirements including VB6 Runtime

This script will:
1. Check Python version
2. Install required Python packages
3. Download and install VB6 Runtime (Windows only)
4. Verify system requirements
5. Create necessary directories
6. Test the installation

Usage: python setup.py
"""

import sys
import os
import subprocess
import platform
from pathlib import Path
import urllib.request
import tempfile
import time


def print_header(text):
    """Print a formatted header"""
    print("\n" + "=" * 80)
    print(f" {text}")
    print("=" * 80 + "\n")


def print_step(step_num, text):
    """Print a step indicator"""
    print(f"\n[{step_num}] {text}")
    print("-" * 40)


def check_python_version():
    """Check if Python version is sufficient"""
    print_step(1, "Checking Python version")

    version = sys.version_info
    print(f"Python version: {version.major}.{version.minor}.{version.micro}")

    if version.major < 3 or (version.major == 3 and version.minor < 7):
        print("❌ Error: Python 3.7 or higher is required!")
        print(f"   Current version: {version.major}.{version.minor}.{version.micro}")
        return False

    print("✓ Python version is sufficient")
    return True


def install_requirements():
    """Install required Python packages"""
    print_step(2, "Installing Python packages")

    requirements_file = Path(__file__).parent / "requirements.txt"

    if not requirements_file.exists():
        print("❌ Error: requirements.txt not found!")
        return False

    print(f"Installing packages from: {requirements_file}")
    print("This may take a few minutes...\n")

    try:
        # Try to install with pip
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", "-r", str(requirements_file)],
            capture_output=True,
            text=True,
            check=True
        )
        print(result.stdout)
        print("✓ All packages installed successfully")
        return True

    except subprocess.CalledProcessError as e:
        print("❌ Error installing packages:")
        print(e.stderr)
        print("\nTrying alternative installation method...")

        # Try installing packages one by one
        try:
            with open(requirements_file) as f:
                for line in f:
                    line = line.strip()
                    if line and not line.startswith('#'):
                        # Handle platform-specific requirements
                        if ';' in line:
                            package, condition = line.split(';')
                            # Skip platform-specific packages on wrong platform
                            if 'platform_system' in condition:
                                if "Windows" in condition and platform.system() != "Windows":
                                    print(f"⊗ Skipping Windows-only package: {package.strip()}")
                                    continue

                        print(f"Installing: {line}")
                        subprocess.run(
                            [sys.executable, "-m", "pip", "install", line],
                            check=False,
                            capture_output=True
                        )

            print("✓ Packages installed (some may have been skipped)")
            return True

        except Exception as e2:
            print(f"❌ Error: {e2}")
            return False


def check_system_requirements():
    """Check system-specific requirements"""
    print_step(3, "Checking system requirements")

    system = platform.system()
    print(f"Operating System: {system}")
    print(f"Architecture: {platform.machine()}")

    if system == "Windows":
        print("✓ Running on Windows - native support available")
        return True

    elif system in ["Linux", "Darwin"]:
        # Check for Wine
        import shutil
        wine_path = shutil.which("wine")

        if wine_path:
            print(f"✓ Wine found at: {wine_path}")
            return True
        else:
            print("⚠ Warning: Wine not found!")
            print("\n  Wine is required to run Windows applications on Linux/Mac.")
            print("\n  Installation instructions:")
            if system == "Linux":
                print("    Ubuntu/Debian: sudo apt-get install wine")
                print("    Fedora: sudo dnf install wine")
                print("    Arch: sudo pacman -S wine")
            else:  # Darwin/Mac
                print("    macOS: brew install wine-stable")
                print("    (Requires Homebrew: https://brew.sh/)")

            print("\n  The client will still work, but tasks cannot be launched without Wine.")
            return False

    else:
        print(f"⚠ Warning: Unsupported operating system: {system}")
        return False


def create_directories():
    """Create necessary directories"""
    print_step(4, "Creating directories")

    base_dir = Path(__file__).parent
    directories = [
        base_dir / "data_output",
        base_dir / "data_backup"
    ]

    for directory in directories:
        try:
            directory.mkdir(exist_ok=True)
            print(f"✓ Created: {directory.name}/")
        except Exception as e:
            print(f"❌ Error creating {directory.name}/: {e}")
            return False

    return True


def is_admin():
    """Check if running with administrator privileges (Windows only)"""
    try:
        import ctypes
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False


def download_vb6_runtime():
    """Download VB6 Runtime SP6 from Microsoft"""
    print("\n  Downloading VB6 Runtime SP6 from Microsoft...")
    print("  This may take a few minutes depending on your connection...")

    # Microsoft's official download URL
    url = "https://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VBRun60sp6.exe"

    temp_dir = tempfile.gettempdir()
    installer_path = os.path.join(temp_dir, "VBRun60sp6.exe")

    try:
        def reporthook(count, block_size, total_size):
            if total_size > 0:
                percent = int(count * block_size * 100 / total_size)
                sys.stdout.write(f"\r  Progress: {percent}% ")
                sys.stdout.flush()

        urllib.request.urlretrieve(url, installer_path, reporthook)
        print("\n  ✓ Download complete!")
        return installer_path
    except Exception as e:
        print(f"\n  ✗ Download failed: {e}")
        print("\n  You can download manually from:")
        print("  https://www.microsoft.com/en-us/download/details.aspx?id=24417")
        return None


def install_vb6_runtime_auto():
    """Automatically download and install VB6 Runtime SP6"""
    print("\n  Installing VB6 Runtime SP6...")

    # Download the installer
    installer_path = download_vb6_runtime()
    if not installer_path:
        return False

    try:
        # Run the installer silently
        print("  Running installer (this may take a minute)...")
        result = subprocess.run(
            [installer_path, "/q"],  # /q for quiet/silent installation
            capture_output=True,
            text=True,
            timeout=300  # 5 minute timeout
        )

        if result.returncode == 0:
            print("  ✓ VB6 Runtime installed successfully!")

            # Clean up
            try:
                os.remove(installer_path)
                print("  ✓ Cleaned up temporary files")
            except:
                pass

            return True
        else:
            print(f"  ⚠ Installer returned code: {result.returncode}")
            print("  The installer may require interactive input.")
            print(f"  You can run it manually from: {installer_path}")
            return False

    except subprocess.TimeoutExpired:
        print("  ⚠ Installation timed out")
        print(f"  You can run the installer manually from: {installer_path}")
        return False
    except Exception as e:
        print(f"  ✗ Installation failed: {e}")
        print(f"  You can run the installer manually from: {installer_path}")
        return False


def check_vb6_dependencies():
    """Check if VB6 runtime dependencies are installed (Windows only)"""
    print_step(5, "Checking VB6 runtime dependencies")

    if platform.system() != "Windows":
        print("⊗ Skipped (not Windows)")
        return True

    try:
        # Import the VB6 checker
        import sys
        sys.path.insert(0, str(Path(__file__).parent / "scripts"))
        from check_vb6_dependencies import check_dependencies

        # Suppress the output and just get the result
        import io
        import contextlib

        # Capture output
        f = io.StringIO()
        with contextlib.redirect_stdout(f):
            all_present = check_dependencies()

        if all_present:
            print("✓ VB6 runtime dependencies are installed")
            return True
        else:
            print("⚠ VB6 runtime dependencies are MISSING")
            print("\n  This will prevent tasks from running!")
            print("  You'll see error: 'System Error &H8007007E - Module not found'")

            # Offer automatic installation
            print("\n  Would you like to automatically download and install VB6 Runtime SP6?")
            print("  This will:")
            print("    • Download VBRun60sp6.exe from Microsoft (~1.4 MB)")
            print("    • Install it automatically")
            print("    • Requires Administrator privileges")

            response = input("\n  Install VB6 Runtime now? (y/n): ").strip().lower()

            if response in ['y', 'yes']:
                # Check for admin privileges
                if not is_admin():
                    print("\n  ⚠ Administrator privileges required!")
                    print("  Please run this script as Administrator:")
                    print("    1. Right-click Command Prompt or PowerShell")
                    print("    2. Select 'Run as Administrator'")
                    print("    3. Navigate to CAPER_suite folder")
                    print("    4. Run: python setup.py")
                    return False

                # Attempt automatic installation
                if install_vb6_runtime_auto():
                    print("\n  ✓ VB6 Runtime installed!")
                    print("  Verifying installation...")

                    # Wait a moment for system to register
                    time.sleep(2)

                    # Check again
                    f2 = io.StringIO()
                    with contextlib.redirect_stdout(f2):
                        all_present_now = check_dependencies()

                    if all_present_now:
                        print("  ✓ VB6 Runtime verified successfully!")
                        return True
                    else:
                        print("  ⚠ Some components may still be missing")
                        print("  A system restart may be required")
                        return False
                else:
                    print("\n  Automatic installation failed.")
                    print("  Please install manually:")
                    print("    1. Run as Administrator: scripts\\install_vb6_runtime.bat")
                    print("    2. See docs/FIX_VB6_RUNTIME.md for instructions")
                    return False
            else:
                print("\n  Skipping automatic installation.")
                print("  To install later:")
                print("    1. Run as Administrator: scripts\\install_vb6_runtime.bat")
                print("    2. Or manually: python scripts\\install_vb6_runtime.py")
                print("    3. See docs/FIX_VB6_RUNTIME.md for detailed instructions")
                return False

    except Exception as e:
        print(f"⚠ Could not check VB6 dependencies: {e}")
        print("\n  You can check manually by running:")
        print("    scripts\\check_vb6_dependencies.bat")
        return False


def verify_installation():
    """Verify that installation was successful"""
    print_step(6, "Verifying installation")

    try:
        # Try importing the modules
        import config
        from task_manager import TaskManager

        print("✓ Python modules loaded successfully")

        # Check if task files exist
        task_manager = TaskManager()
        available_tasks = sum(1 for task_id in config.get_all_task_ids()
                             if config.task_exists(task_id))
        total_tasks = len(config.PSYCHOLOGY_TASKS)

        print(f"✓ Found {available_tasks}/{total_tasks} psychology tasks")

        if available_tasks == 0:
            print("\n⚠ Warning: No task executables found!")
            print("  Make sure all task directories contain their .exe files")

        return True

    except Exception as e:
        print(f"❌ Error during verification: {e}")
        import traceback
        traceback.print_exc()
        return False


def print_next_steps():
    """Print instructions for next steps"""
    print_header("SETUP COMPLETE!")

    print("You can now use the CAPER Psychology Client in several ways:\n")

    print("METHOD 1: Using the launcher scripts (easiest)")
    if platform.system() == "Windows":
        print("  Double-click: run.bat")
        print("  Or from command line: run.bat")
    else:
        print("  From terminal: ./run.sh")
        print("  Or: bash run.sh")

    print("\nMETHOD 2: Direct Python execution")
    print("  python psychology_client.py")

    print("\nMETHOD 3: As a Python module")
    print("  python -m psychology_client")

    print("\nFor help and documentation:")
    print("  See README.md for complete instructions")
    print("  Use the Help option in the client menu")

    print("\n" + "=" * 80 + "\n")


def main():
    """Main setup routine"""
    print_header("CAPER SUITE - ONE-CLICK SETUP")

    print("This script will automatically set up everything you need:")
    print("  • Check Python version and install packages")
    print("  • Download and install VB6 Runtime (if needed)")
    print("  • Verify system requirements")
    print("  • Create necessary directories")
    print("\nThe setup will take a few minutes.\n")

    if platform.system() == "Windows" and not is_admin():
        print("⚠ IMPORTANT: VB6 Runtime installation requires Administrator privileges!")
        print("\nFor best results:")
        print("  1. Close this window")
        print("  2. Right-click 'setup.bat' or Command Prompt")
        print("  3. Select 'Run as Administrator'")
        print("  4. Run: python setup.py")
        print("\nYou can continue without admin rights, but VB6 Runtime")
        print("installation will be skipped.\n")

    input("Press Enter to begin setup...")

    # Run setup steps
    steps_passed = 0
    total_steps = 6
    vb6_installed = True

    if check_python_version():
        steps_passed += 1

    if install_requirements():
        steps_passed += 1

    if check_system_requirements():
        steps_passed += 1
    else:
        # Still count as passed, just with warnings
        steps_passed += 1

    if create_directories():
        steps_passed += 1

    # Check VB6 dependencies (Windows only)
    if check_vb6_dependencies():
        steps_passed += 1
    else:
        # Count as passed but remember it's missing
        steps_passed += 1
        vb6_installed = False

    if verify_installation():
        steps_passed += 1

    # Print results
    print("\n" + "=" * 80)
    print(f" SETUP RESULTS: {steps_passed}/{total_steps} steps completed")
    print("=" * 80)

    if steps_passed == total_steps and vb6_installed:
        print("\n✓ Setup completed successfully!")
        print("\n" + "=" * 80)
        print("ALL SYSTEMS READY!")
        print("=" * 80)
        print("\nYour CAPER Suite is fully configured and ready to use.")
        if platform.system() == "Windows":
            print("\nIMPORTANT: If VB6 Runtime was just installed, please restart")
            print("your computer before running tasks for the first time.")
        print_next_steps()
        return 0
    else:
        print("\n⚠ Setup completed with warnings.")
        if not vb6_installed and platform.system() == "Windows":
            print("\n" + "!" * 80)
            print("IMPORTANT: VB6 Runtime is NOT installed!")
            print("!" * 80)
            print("\nTasks will NOT work until you install VB6 Runtime SP6.")
            print("\nTo fix this:")
            print("  Option 1: Run setup again as Administrator")
            print("    • Right-click setup.bat → 'Run as Administrator'")
            print("    • Or: Right-click Command Prompt → 'Run as Administrator'")
            print("    • Then run: python setup.py")
            print("\n  Option 2: Manual installation")
            print("    • Right-click: scripts\\install_vb6_runtime.bat")
            print("    • Select 'Run as Administrator'")
            print("    • Follow the installation wizard")
            print("\nFor detailed instructions, see: docs/FIX_VB6_RUNTIME.md")
            print("!" * 80)
        print("\nPlease review the messages above and resolve any issues.\n")
        return 1


if __name__ == "__main__":
    try:
        exit_code = main()
        sys.exit(exit_code)
    except KeyboardInterrupt:
        print("\n\nSetup interrupted by user. Exiting...")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Setup failed with error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
