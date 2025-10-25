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
            print(f"\nLaunching: {self.exe_path}")
            self.process = subprocess.Popen(
                [str(self.exe_path)],
                cwd=str(self.exe_path.parent)
            )

            # Give process time to create its window
            print("Waiting for window to initialize...")
            time.sleep(1.5)

            # Check if process started successfully
            if self.process.poll() is not None:
                print("✗ Process terminated immediately")
                return False

            # Try to center and position the window
            if self.is_windows:
                self._center_and_position_window()

                # Keep repositioning for a few seconds to handle VB6 apps
                # that move their windows during initialization
                import threading

                def keep_centered():
                    """Keep repositioning the window for a few seconds"""
                    for i in range(5):
                        time.sleep(0.5)
                        if self.hwnd and self.process.poll() is None:
                            try:
                                import ctypes
                                from ctypes import wintypes
                                user32 = ctypes.windll.user32

                                # Get current position
                                rect = wintypes.RECT()
                                user32.GetWindowRect(self.hwnd, ctypes.byref(rect))
                                current_width = rect.right - rect.left
                                current_height = rect.bottom - rect.top

                                # Calculate centered position
                                screen_width = user32.GetSystemMetrics(0)
                                screen_height = user32.GetSystemMetrics(1)
                                x = (screen_width - current_width) // 2
                                y = (screen_height - current_height) // 2

                                # Reposition if needed
                                current_x = rect.left
                                current_y = rect.top

                                # Only reposition if significantly off-center (more than 50 pixels)
                                if abs(current_x - x) > 50 or abs(current_y - y) > 50:
                                    user32.SetWindowPos(
                                        self.hwnd, 0, x, y, 0, 0,
                                        0x0004 | 0x0001 | 0x0040  # SWP_NOZORDER | SWP_NOSIZE | SWP_SHOWWINDOW
                                    )
                                    print(f"  Re-centered window (was at {current_x},{current_y}, moved to {x},{y})")
                            except:
                                pass

                # Start the repositioning thread
                centering_thread = threading.Thread(target=keep_centered, daemon=True)
                centering_thread.start()

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
            print("Searching for task window...")
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
                    print(f"Found window (handle: {self.hwnd})")
                    break

                time.sleep(0.1)

            if self.hwnd:
                # Get screen dimensions
                screen_width = user32.GetSystemMetrics(0)  # SM_CXSCREEN
                screen_height = user32.GetSystemMetrics(1)  # SM_CYSCREEN

                print(f"Screen dimensions: {screen_width}x{screen_height}")

                # Wait for the window to have a valid size (not 0x0)
                print("Waiting for window to render...")
                current_width = 0
                current_height = 0
                wait_attempts = 0
                max_wait_attempts = 30  # 3 seconds

                while (current_width == 0 or current_height == 0) and wait_attempts < max_wait_attempts:
                    rect = wintypes.RECT()
                    user32.GetWindowRect(self.hwnd, ctypes.byref(rect))
                    current_width = rect.right - rect.left
                    current_height = rect.bottom - rect.top

                    if current_width > 0 and current_height > 0:
                        print(f"✓ Window rendered with size: {current_width}x{current_height}")
                        break

                    wait_attempts += 1
                    time.sleep(0.1)

                if current_width == 0 or current_height == 0:
                    print(f"⚠ Window size still 0x0 after {wait_attempts} attempts")
                    print("  Unable to center window - it may not be fully initialized")
                    return

                # Now position the window multiple times
                # (VB6 apps sometimes reposition themselves during initialization)
                for reposition_attempt in range(3):
                    # Get the current window size (may have changed)
                    rect = wintypes.RECT()
                    user32.GetWindowRect(self.hwnd, ctypes.byref(rect))
                    current_width = rect.right - rect.left
                    current_height = rect.bottom - rect.top

                    # Calculate centered position
                    x = (screen_width - current_width) // 2
                    y = (screen_height - current_height) // 2

                    print(f"Positioning attempt {reposition_attempt + 1}: centering {current_width}x{current_height} window at ({x}, {y})")

                    # Position the window in the center
                    SWP_NOZORDER = 0x0004
                    SWP_NOSIZE = 0x0001
                    SWP_SHOWWINDOW = 0x0040

                    result = user32.SetWindowPos(
                        self.hwnd,
                        0,  # HWND_TOP
                        x,
                        y,
                        0,  # Keep current width
                        0,  # Keep current height
                        SWP_NOZORDER | SWP_NOSIZE | SWP_SHOWWINDOW
                    )

                    if result:
                        print(f"  ✓ SetWindowPos succeeded")
                    else:
                        error = ctypes.get_last_error()
                        print(f"  ✗ SetWindowPos failed with error: {error}")

                    # Bring window to foreground
                    user32.SetForegroundWindow(self.hwnd)

                    # Wait a bit before trying again
                    if reposition_attempt < 2:
                        time.sleep(0.4)

                # Verify final position
                rect = wintypes.RECT()
                user32.GetWindowRect(self.hwnd, ctypes.byref(rect))
                final_x = rect.left
                final_y = rect.top
                print(f"✓ Window centering complete - final position: ({final_x}, {final_y})")

            else:
                print("⚠ Could not find task window - it may still be starting")
                print("  Task will appear at its default position")

        except Exception as e:
            # If positioning fails, the window will still run at its default position
            print(f"⚠ Could not center window automatically: {e}")
            print(f"  Task window opened at default position")

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
