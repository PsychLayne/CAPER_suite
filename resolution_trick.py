"""
Resolution Trick for VB6 Programs
Temporarily changes screen resolution to trick VB6 programs into centering themselves
"""

import ctypes
from ctypes import wintypes
import time


class ResolutionTrick:
    """Temporarily change screen resolution to trick old programs"""

    def __init__(self):
        self.user32 = ctypes.windll.user32
        self.original_width = None
        self.original_height = None

    def get_current_resolution(self):
        """Get current screen resolution"""
        return self.user32.GetSystemMetrics(0), self.user32.GetSystemMetrics(1)

    def change_resolution(self, width, height):
        """Change screen resolution"""
        devmode = wintypes.DEVMODEW()
        devmode.dmSize = ctypes.sizeof(wintypes.DEVMODEW)
        devmode.dmPelsWidth = width
        devmode.dmPelsHeight = height
        devmode.dmFields = 0x00180000  # DM_PELSWIDTH | DM_PELSHEIGHT

        result = self.user32.ChangeDisplaySettingsW(ctypes.byref(devmode), 0)
        return result == 0  # DISP_CHANGE_SUCCESSFUL

    def temporary_resolution_for_launch(self, launch_func, temp_width=1024, temp_height=768):
        """
        Temporarily change resolution, run launch function, then restore

        Args:
            launch_func: Function to call while resolution is changed
            temp_width: Temporary width (default 1024)
            temp_height: Temporary height (default 768)
        """
        # Save current resolution
        self.original_width, self.original_height = self.get_current_resolution()
        print(f"Current resolution: {self.original_width}x{self.original_height}")

        try:
            # Change to temporary resolution
            print(f"Changing to {temp_width}x{temp_height}...")
            if self.change_resolution(temp_width, temp_height):
                print(f"✓ Resolution changed to {temp_width}x{temp_height}")

                # Wait a moment for display to settle
                time.sleep(0.5)

                # Run the launch function
                result = launch_func()

                # Wait for program to position itself
                time.sleep(2)

                # Restore original resolution
                print(f"Restoring to {self.original_width}x{self.original_height}...")
                self.change_resolution(self.original_width, self.original_height)
                print(f"✓ Resolution restored")

                return result
            else:
                print("✗ Failed to change resolution")
                # Just run normally
                return launch_func()

        except Exception as e:
            print(f"Error during resolution trick: {e}")
            # Make sure we restore resolution even if something fails
            if self.original_width and self.original_height:
                self.change_resolution(self.original_width, self.original_height)
            raise


def launch_with_resolution_trick(exe_path, temp_width=1024, temp_height=768):
    """
    Launch a program with temporary resolution change

    Args:
        exe_path: Path to executable
        temp_width: Temporary screen width
        temp_height: Temporary screen height

    Returns:
        subprocess.Popen: The launched process
    """
    import subprocess
    from pathlib import Path

    trick = ResolutionTrick()

    def launch():
        exe = Path(exe_path)
        process = subprocess.Popen([str(exe)], cwd=str(exe.parent))
        return process

    return trick.temporary_resolution_for_launch(launch, temp_width, temp_height)
