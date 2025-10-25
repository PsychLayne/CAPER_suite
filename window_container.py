"""
Window Container for CAPER Suite
Centers VB6 .exe programs on modern displays by embedding them in a container window
"""

import tkinter as tk
import subprocess
import time
import platform
from pathlib import Path


class WindowContainer:
    """Container window that embeds and centers legacy .exe programs"""

    def __init__(self, task_name, exe_path, window_width=800, window_height=600):
        """
        Initialize window container

        Args:
            task_name: Name of the task being launched
            exe_path: Path to the executable
            window_width: Width of the container window (default 800)
            window_height: Height of the container window (default 600)
        """
        self.task_name = task_name
        self.exe_path = Path(exe_path)
        self.window_width = window_width
        self.window_height = window_height
        self.process = None
        self.hwnd = None
        self.is_windows = platform.system() == "Windows"

    def launch_in_container(self):
        """Launch the executable in a centered container window"""
        if not self.is_windows:
            # On Linux/Mac, just launch with Wine normally (no embedding)
            return self._launch_with_wine()

        # Create the container window
        self.root = tk.Tk()
        self.root.title(f"CAPER Suite - {self.task_name}")

        # Set window size
        self.root.geometry(f"{self.window_width}x{self.window_height}")

        # Center the window on screen
        self._center_window()

        # Set window properties
        self.root.configure(bg='#2C3E50')
        self.root.resizable(False, False)

        # Create a frame to hold the embedded window
        self.container_frame = tk.Frame(self.root, bg='#2C3E50')
        self.container_frame.pack(fill='both', expand=True)

        # Add instructions label
        info_label = tk.Label(
            self.root,
            text=f"Task: {self.task_name} | Close this window when task is complete",
            bg='#34495E',
            fg='white',
            font=('Segoe UI', 9),
            pady=5
        )
        info_label.pack(side='bottom', fill='x')

        # Launch the executable
        try:
            self.process = subprocess.Popen(
                [str(self.exe_path)],
                cwd=str(self.exe_path.parent)
            )

            # Give process time to create its window
            time.sleep(0.5)

            # Check if process started successfully
            if self.process.poll() is not None:
                self.root.destroy()
                return False

            # Try to embed the window (Windows only)
            if self.is_windows:
                self._try_embed_window()

            # Handle window close
            self.root.protocol("WM_DELETE_WINDOW", self._on_closing)

            # Monitor process
            self._monitor_process()

            # Start the GUI event loop
            self.root.mainloop()

            return True

        except Exception as e:
            if hasattr(self, 'root'):
                self.root.destroy()
            raise e

    def _center_window(self):
        """Center the window on the screen"""
        self.root.update_idletasks()

        # Get screen dimensions
        screen_width = self.root.winfo_screenwidth()
        screen_height = self.root.winfo_screenheight()

        # Calculate position
        x = (screen_width - self.window_width) // 2
        y = (screen_height - self.window_height) // 2

        # Set position
        self.root.geometry(f"{self.window_width}x{self.window_height}+{x}+{y}")

    def _try_embed_window(self):
        """Attempt to embed the launched window (Windows only)"""
        try:
            import ctypes
            from ctypes import wintypes

            # Windows API functions
            user32 = ctypes.windll.user32

            # Get the window handle of the launched process
            def enum_windows_callback(hwnd, process_id):
                """Callback to find window by process ID"""
                if user32.IsWindowVisible(hwnd):
                    window_process_id = wintypes.DWORD()
                    user32.GetWindowThreadProcessId(hwnd, ctypes.byref(window_process_id))
                    if window_process_id.value == process_id:
                        self.hwnd = hwnd
                        return False  # Stop enumeration
                return True  # Continue enumeration

            # Wait for window to be created
            max_attempts = 20
            for attempt in range(max_attempts):
                # Enumerate windows to find our process's window
                EnumWindowsProc = ctypes.WINFUNCTYPE(
                    ctypes.c_bool,
                    ctypes.POINTER(ctypes.c_int),
                    ctypes.POINTER(ctypes.c_int)
                )

                def callback(hwnd, lParam):
                    return enum_windows_callback(hwnd, self.process.pid)

                user32.EnumWindows(EnumWindowsProc(callback), 0)

                if self.hwnd:
                    break

                time.sleep(0.1)

            if self.hwnd:
                # Get container frame handle
                container_hwnd = self.container_frame.winfo_id()

                # Set the parent of the exe window to our container
                user32.SetParent(self.hwnd, container_hwnd)

                # Remove window decorations (title bar, borders)
                WS_CHILD = 0x40000000
                WS_VISIBLE = 0x10000000
                style = user32.GetWindowLongW(self.hwnd, -16)  # GWL_STYLE
                user32.SetWindowLongW(self.hwnd, -16, WS_CHILD | WS_VISIBLE)

                # Position the embedded window in the center of the container
                # Get the actual size of the embedded window
                rect = wintypes.RECT()
                user32.GetWindowRect(self.hwnd, ctypes.byref(rect))
                exe_width = rect.right - rect.left
                exe_height = rect.bottom - rect.top

                # Center it in the container
                x_pos = (self.window_width - exe_width) // 2
                y_pos = (self.window_height - exe_height - 30) // 2  # Account for info label

                # Move and resize the embedded window
                user32.SetWindowPos(
                    self.hwnd,
                    0,  # HWND_TOP
                    x_pos,
                    y_pos,
                    exe_width,
                    exe_height,
                    0x0040  # SWP_SHOWWINDOW
                )

        except Exception as e:
            # If embedding fails, the window will still run standalone
            print(f"Note: Window embedding not available: {e}")
            print(f"Task window will open separately")

    def _launch_with_wine(self):
        """Launch with Wine on Linux/Mac (no embedding)"""
        import shutil

        wine_path = shutil.which("wine")
        if not wine_path:
            raise RuntimeError("Wine not found. Please install Wine to run Windows applications.")

        self.process = subprocess.Popen(
            [wine_path, str(self.exe_path)],
            cwd=str(self.exe_path.parent)
        )

        return True

    def _monitor_process(self):
        """Monitor the process and close container when it exits"""
        def check_process():
            if self.process and self.process.poll() is not None:
                # Process has ended
                self.root.quit()
            else:
                # Check again in 500ms
                self.root.after(500, check_process)

        # Start monitoring
        self.root.after(500, check_process)

    def _on_closing(self):
        """Handle window close event"""
        # Terminate the process if still running
        if self.process and self.process.poll() is None:
            try:
                self.process.terminate()
                # Give it a moment to terminate gracefully
                time.sleep(0.5)
                if self.process.poll() is None:
                    self.process.kill()
            except:
                pass

        self.root.quit()


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
