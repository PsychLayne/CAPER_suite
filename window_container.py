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

            # Keep searching for the window - VB6 forms take time to appear
            print("Searching for VB6 form window...")
            max_search_attempts = 30  # 3 seconds

            for search_attempt in range(max_search_attempts):
                all_visible_windows = []

                def enum_all_windows_callback(hwnd, lParam):
                    """Find all visible windows with titles"""
                    if user32.IsWindowVisible(hwnd):
                        title_length = user32.GetWindowTextLengthW(hwnd)
                        if title_length > 0:
                            # Get title
                            title_buffer = ctypes.create_unicode_buffer(title_length + 1)
                            user32.GetWindowTextW(hwnd, title_buffer, title_length + 1)
                            title = title_buffer.value

                            # Get class name
                            class_buffer = ctypes.create_unicode_buffer(256)
                            user32.GetClassNameW(hwnd, class_buffer, 256)
                            class_name = class_buffer.value

                            # Get window rect
                            rect = wintypes.RECT()
                            user32.GetWindowRect(hwnd, ctypes.byref(rect))
                            width = rect.right - rect.left
                            height = rect.bottom - rect.top

                            # Only consider windows with actual size and VB6-related classes
                            if width > 0 and height > 0 and ('Thunder' in class_name or 'BART' in title or 'PASAT' in title or 'Mirror' in title):
                                all_visible_windows.append({
                                    'hwnd': hwnd,
                                    'title': title,
                                    'class': class_name,
                                    'width': width,
                                    'height': height,
                                    'left': rect.left,
                                    'top': rect.top
                                })
                    return True

                # Enumerate all windows
                EnumWindowsProc = ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p)
                user32.EnumWindows(EnumWindowsProc(enum_all_windows_callback), 0)

                # Check if we found any matching windows
                if all_visible_windows:
                    print(f"Found {len(all_visible_windows)} VB6 window(s) on attempt {search_attempt + 1}:")
                    for i, win in enumerate(all_visible_windows):
                        print(f"  {i+1}. '{win['title']}' ({win['class']}) - {win['width']}x{win['height']} at ({win['left']},{win['top']})")

                    # Look for a matching window
                    for win in all_visible_windows:
                        # Match by task name or common keywords
                        task_keywords = self.task_name.upper().replace(' - ', ' ').replace('_', ' ').split()
                        title_upper = win['title'].upper()

                        # Check if any keyword matches
                        if any(keyword in title_upper for keyword in task_keywords) or 'Thunder' in win['class']:
                            print(f"✓ Found matching window: '{win['title']}'")
                            self.hwnd = win['hwnd']

                            # Get screen dimensions
                            screen_width = user32.GetSystemMetrics(0)
                            screen_height = user32.GetSystemMetrics(1)

                            # Calculate center position
                            x = (screen_width - win['width']) // 2
                            y = (screen_height - win['height']) // 2

                            print(f"Centering {win['width']}x{win['height']} window at ({x}, {y})")

                            # Move window to center
                            result = user32.SetWindowPos(
                                self.hwnd, 0, x, y, 0, 0,
                                0x0004 | 0x0001 | 0x0040  # NOZORDER | NOSIZE | SHOWWINDOW
                            )

                            if result:
                                print("✓ Window centered successfully!")
                            else:
                                error = ctypes.get_last_error()
                                print(f"⚠ SetWindowPos failed with error: {error}")

                            user32.SetForegroundWindow(self.hwnd)
                            return

                # Wait before trying again
                time.sleep(0.1)

            print("⚠ No matching VB6 form windows found after 3 seconds")
            print("  The window may have already appeared at its default position")

        except Exception as e:
            print(f"⚠ Error during window positioning: {e}")
            import traceback
            traceback.print_exc()

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
