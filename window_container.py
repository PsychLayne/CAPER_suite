"""
Window Container for CAPER Suite
Centers and positions VB6 .exe programs on modern displays
"""

import subprocess
import time
import platform
from pathlib import Path


class WindowContainer:
    """Positions and centers legacy .exe program windows"""

    def __init__(self, task_name, exe_path, window_width=800, window_height=600):
        """
        Initialize window container

        Args:
            task_name: Name of the task being launched
            exe_path: Path to the executable
            window_width: Desired width (default 800)
            window_height: Desired height (default 600)
        """
        self.task_name = task_name
        self.exe_path = Path(exe_path)
        self.window_width = window_width
        self.window_height = window_height
        self.process = None
        self.hwnd = None
        self.is_windows = platform.system() == "Windows"

    def launch_in_container(self):
        """Launch the executable and position it in the center of the screen"""
        if not self.is_windows:
            # On Linux/Mac, just launch with Wine normally
            return self._launch_with_wine()

        # Launch the executable first
        try:
            self.process = subprocess.Popen(
                [str(self.exe_path)],
                cwd=str(self.exe_path.parent)
            )

            # Give process time to create its window
            time.sleep(1.0)

            # Check if process started successfully
            if self.process.poll() is not None:
                return False

            # Try to center and position the window
            if self.is_windows:
                self._center_and_position_window()

            return True

        except Exception as e:
            raise e

    def _center_and_position_window(self):
        """Center the window on screen using Win32 API"""
        try:
            import ctypes
            from ctypes import wintypes

            # Windows API functions
            user32 = ctypes.windll.user32

            # Find the window by process ID
            found_windows = []

            def enum_windows_callback(hwnd, lParam):
                """Callback to find windows by process ID"""
                if user32.IsWindowVisible(hwnd):
                    window_process_id = wintypes.DWORD()
                    user32.GetWindowThreadProcessId(hwnd, ctypes.byref(window_process_id))
                    if window_process_id.value == self.process.pid:
                        # Get window title to make sure it's a real window
                        length = user32.GetWindowTextLengthW(hwnd)
                        if length > 0:
                            found_windows.append(hwnd)
                return True  # Continue enumeration

            # Wait for window to be created with multiple attempts
            max_attempts = 30
            for attempt in range(max_attempts):
                found_windows.clear()

                # Enumerate windows
                EnumWindowsProc = ctypes.WINFUNCTYPE(
                    ctypes.c_bool,
                    ctypes.POINTER(ctypes.c_int),
                    ctypes.POINTER(ctypes.c_int)
                )
                user32.EnumWindows(EnumWindowsProc(enum_windows_callback), 0)

                if found_windows:
                    self.hwnd = found_windows[0]  # Use first found window
                    break

                time.sleep(0.1)

            if self.hwnd:
                # Get screen dimensions
                screen_width = user32.GetSystemMetrics(0)  # SM_CXSCREEN
                screen_height = user32.GetSystemMetrics(1)  # SM_CYSCREEN

                # Get the current window size
                rect = wintypes.RECT()
                user32.GetWindowRect(self.hwnd, ctypes.byref(rect))
                current_width = rect.right - rect.left
                current_height = rect.bottom - rect.top

                # Calculate centered position
                x = (screen_width - current_width) // 2
                y = (screen_height - current_height) // 2

                # Position the window in the center
                SWP_NOZORDER = 0x0004
                SWP_NOSIZE = 0x0001
                SWP_SHOWWINDOW = 0x0040

                user32.SetWindowPos(
                    self.hwnd,
                    0,  # HWND_TOP
                    x,
                    y,
                    0,  # Keep current width
                    0,  # Keep current height
                    SWP_NOZORDER | SWP_NOSIZE | SWP_SHOWWINDOW
                )

                # Bring window to foreground
                user32.SetForegroundWindow(self.hwnd)

        except Exception as e:
            # If positioning fails, the window will still run at its default position
            print(f"Note: Could not center window automatically: {e}")
            print(f"Task window opened at default position")

    def _launch_with_wine(self):
        """Launch with Wine on Linux/Mac"""
        import shutil

        wine_path = shutil.which("wine")
        if not wine_path:
            raise RuntimeError("Wine not found. Please install Wine to run Windows applications.")

        self.process = subprocess.Popen(
            [wine_path, str(self.exe_path)],
            cwd=str(self.exe_path.parent)
        )

        return True


def launch_task_in_container(task_name, exe_path, window_width=800, window_height=600):
    """
    Convenience function to launch a task in a centered container

    Args:
        task_name: Name of the task
        exe_path: Path to the executable
        window_width: Container width (default 800)
        window_height: Container height (default 600)

    Returns:
        bool: True if launched successfully
    """
    container = WindowContainer(task_name, exe_path, window_width, window_height)
    return container.launch_in_container()
