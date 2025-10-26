#!/usr/bin/env python3
"""
CAPER Suite GUI Launcher with Resolution Management
Changes to 1024x768 for optimal VB6 program display, then restores on exit
"""

import sys
import ctypes
from ctypes import wintypes
import platform
import atexit


# Define DEVMODEW structure for changing resolution
class DEVMODEW(ctypes.Structure):
    _fields_ = [
        ('dmDeviceName', ctypes.c_wchar * 32),
        ('dmSpecVersion', ctypes.c_ushort),
        ('dmDriverVersion', ctypes.c_ushort),
        ('dmSize', ctypes.c_ushort),
        ('dmDriverExtra', ctypes.c_ushort),
        ('dmFields', ctypes.c_ulong),
        ('dmPositionX', ctypes.c_long),
        ('dmPositionY', ctypes.c_long),
        ('dmDisplayOrientation', ctypes.c_ulong),
        ('dmDisplayFixedOutput', ctypes.c_ulong),
        ('dmColor', ctypes.c_short),
        ('dmDuplex', ctypes.c_short),
        ('dmYResolution', ctypes.c_short),
        ('dmTTOption', ctypes.c_short),
        ('dmCollate', ctypes.c_short),
        ('dmFormName', ctypes.c_wchar * 32),
        ('dmLogPixels', ctypes.c_ushort),
        ('dmBitsPerPel', ctypes.c_ulong),
        ('dmPelsWidth', ctypes.c_ulong),
        ('dmPelsHeight', ctypes.c_ulong),
        ('dmDisplayFlags', ctypes.c_ulong),
        ('dmDisplayFrequency', ctypes.c_ulong),
        ('dmICMMethod', ctypes.c_ulong),
        ('dmICMIntent', ctypes.c_ulong),
        ('dmMediaType', ctypes.c_ulong),
        ('dmDitherType', ctypes.c_ulong),
        ('dmReserved1', ctypes.c_ulong),
        ('dmReserved2', ctypes.c_ulong),
        ('dmPanningWidth', ctypes.c_ulong),
        ('dmPanningHeight', ctypes.c_ulong),
    ]


def change_resolution(width, height):
    """Change screen resolution on Windows"""
    if platform.system() != "Windows":
        print("Resolution management only available on Windows")
        return False

    user32 = ctypes.windll.user32
    devmode = DEVMODEW()
    devmode.dmSize = ctypes.sizeof(DEVMODEW)
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

    # Define restoration function
    def restore_resolution():
        """Restore original resolution - called on exit"""
        if original_width and original_height:
            print(f"\nRestoring resolution to {original_width}x{original_height}...")
            try:
                if change_resolution(original_width, original_height):
                    print("✓ Resolution restored successfully")
                else:
                    print("⚠ Could not restore resolution automatically")
                    print(f"   Please manually change to {original_width}x{original_height}")
                    print("   (Right-click desktop → Display settings → Resolution)")
            except Exception as e:
                print(f"⚠ Error restoring resolution: {e}")
                print(f"   Please manually change to {original_width}x{original_height}")

    # Register restoration function to run on exit (even if program crashes)
    atexit.register(restore_resolution)

    # Change to 1024x768 for VB6 programs
    print("Changing to 1024x768 for optimal VB6 program display...")
    resolution_changed = False
    if change_resolution(1024, 768):
        print("✓ Resolution changed to 1024x768")
        resolution_changed = True
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
        print(f"\n{'='*60}")
        print(f"ERROR: Failed to launch GUI")
        print(f"{'='*60}")
        print(f"\nError: {e}")
        print(f"\nFull traceback:")
        import traceback
        traceback.print_exc()
        print(f"\n{'='*60}")
        input("\nPress Enter to exit...")

    # Note: atexit.register will automatically call restore_resolution()


if __name__ == "__main__":
    main()
