#!/usr/bin/env python3
"""
CAPER Suite GUI Launcher with Resolution Management
Changes to 1024x768 for optimal VB6 program display, then restores on exit
"""

import sys
import ctypes
from ctypes import wintypes
import platform


def change_resolution(width, height):
    """Change screen resolution on Windows"""
    if platform.system() != "Windows":
        print("Resolution management only available on Windows")
        return False

    user32 = ctypes.windll.user32
    devmode = wintypes.DEVMODEW()
    devmode.dmSize = ctypes.sizeof(wintypes.DEVMODEW)
    devmode.dmPelsWidth = width
    devmode.dmPelsHeight = height
    devmode.dmFields = 0x00180000  # DM_PELSWIDTH | DM_PELSHEIGHT

    result = user32.ChangeDisplaySettingsW(ctypes.byref(devmode), 0)
    return result == 0  # DISP_CHANGE_SUCCESSFUL


def get_current_resolution():
    """Get current screen resolution"""
    if platform.system() != "Windows":
        return None, None

    user32 = ctypes.windll.user32
    return user32.GetSystemMetrics(0), user32.GetSystemMetrics(1)


def main():
    """Launch GUI with resolution management"""
    # Check if Windows
    if platform.system() != "Windows":
        print("This launcher is for Windows only.")
        print("On Linux/Mac, run: python psychology_client_gui.py")
        sys.exit(1)

    # Save current resolution
    original_width, original_height = get_current_resolution()
    print(f"Current resolution: {original_width}x{original_height}")

    # Change to 1024x768 for VB6 programs
    print("Changing to 1024x768 for optimal VB6 program display...")
    if change_resolution(1024, 768):
        print("✓ Resolution changed to 1024x768")
    else:
        print("⚠ Could not change resolution, continuing at current resolution")

    try:
        # Import and run the GUI
        from psychology_client_gui import main as gui_main
        print("\nLaunching CAPER Suite GUI...\n")
        gui_main()

    except KeyboardInterrupt:
        print("\nExiting...")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()

    finally:
        # Always restore original resolution
        if original_width and original_height:
            print(f"\nRestoring resolution to {original_width}x{original_height}...")
            if change_resolution(original_width, original_height):
                print("✓ Resolution restored")
            else:
                print("⚠ Could not restore resolution automatically")
                print(f"   Please manually change back to {original_width}x{original_height}")
                print("   (Right-click desktop → Display settings → Resolution)")


if __name__ == "__main__":
    main()
