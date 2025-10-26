#!/usr/bin/env python3
"""
CAPER Suite GUI Launcher with Resolution Management
Changes to 1024x768 for optimal VB6 program display, then restores on exit
"""

import sys
import ctypes
from ctypes import wintypes
import platform


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

    # Change to 1024x768 for VB6 programs
    print("Changing to 1024x768 for optimal VB6 program display...")
    resolution_changed = False
    if change_resolution(1024, 768):
        print("✓ Resolution changed to 1024x768")
        resolution_changed = True
    else:
        print("⚠ Could not change resolution, continuing at current resolution")

    try:
        # Import GUI module
        from psychology_client_gui import PsychologyClientGUI
        import tkinter as tk

        print("\nLaunching CAPER Suite GUI...\n")

        # Create root window
        root = tk.Tk()

        # Create GUI app
        app = PsychologyClientGUI(root)

        # Bind restoration to window close
        def on_closing():
            """Called when window is closed"""
            print("\nClosing GUI...")
            if original_width and original_height and resolution_changed:
                print(f"Restoring resolution to {original_width}x{original_height}...")
                if change_resolution(original_width, original_height):
                    print("✓ Resolution restored successfully")
                else:
                    print("⚠ Could not restore resolution")
            root.destroy()

        # Set up window close protocol
        root.protocol("WM_DELETE_WINDOW", on_closing)

        # Also bind ESC to trigger restoration
        original_toggle = app.toggle_fullscreen
        def toggle_with_restore(event=None):
            result = original_toggle(event)
            # If we're exiting fullscreen to close, restore resolution
            return result
        app.toggle_fullscreen = toggle_with_restore

        # Run GUI
        root.mainloop()

        # Ensure restoration happens even if mainloop exits normally
        if original_width and original_height and resolution_changed:
            print(f"\nRestoring resolution to {original_width}x{original_height}...")
            if change_resolution(original_width, original_height):
                print("✓ Resolution restored")

    except KeyboardInterrupt:
        print("\nExiting...")
        # Restore resolution
        if original_width and original_height and resolution_changed:
            print(f"Restoring resolution to {original_width}x{original_height}...")
            change_resolution(original_width, original_height)

    except Exception as e:
        print(f"\n{'='*60}")
        print(f"ERROR: Failed to launch GUI")
        print(f"{'='*60}")
        print(f"\nError: {e}")
        print(f"\nFull traceback:")
        import traceback
        traceback.print_exc()
        print(f"\n{'='*60}")

        # Restore resolution even on error
        if original_width and original_height and resolution_changed:
            print(f"\nRestoring resolution to {original_width}x{original_height}...")
            change_resolution(original_width, original_height)

        input("\nPress Enter to exit...")


if __name__ == "__main__":
    main()
