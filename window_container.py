"""
Window Container for CAPER Suite
Creates a fullscreen overlay container for VB6 programs to provide context and centering
"""

import tkinter as tk
import subprocess
import time
import platform
from pathlib import Path
import threading


class WindowContainer:
    """Fullscreen overlay container that provides visual context for VB6 programs"""

    def __init__(self, task_name, exe_path, window_width=800, window_height=600):
        """
        Initialize window container

        Args:
            task_name: Name of the task being launched
            exe_path: Path to the executable
            window_width: Not used (for compatibility)
            window_height: Not used (for compatibility)
        """
        self.task_name = task_name
        self.exe_path = Path(exe_path)
        self.process = None
        self.hwnd = None
        self.is_windows = platform.system() == "Windows"
        self.root = None
        self.keep_running = True

    def launch_in_container(self):
        """Launch the executable with a fullscreen overlay container"""
        if not self.is_windows:
            # On Linux/Mac, just launch with Wine normally
            return self._launch_with_wine()

        # Create fullscreen container
        self.root = tk.Tk()
        self.root.title(f"CAPER Suite - {self.task_name}")

        # Make it fullscreen and borderless
        self.root.attributes('-fullscreen', True)
        self.root.attributes('-topmost', False)  # Don't stay on top - let VB6 window appear above

        # Dark background
        self.root.configure(bg='#1a1a1a')

        # Info panel at top
        info_frame = tk.Frame(self.root, bg='#2C3E50', height=60)
        info_frame.pack(side='top', fill='x')
        info_frame.pack_propagate(False)

        # Task name
        task_label = tk.Label(
            info_frame,
            text=f"🧠 {self.task_name}",
            bg='#2C3E50',
            fg='white',
            font=('Segoe UI', 16, 'bold')
        )
        task_label.pack(side='left', padx=30, pady=15)

        # Instructions
        instructions = tk.Label(
            info_frame,
            text="The task window will appear centered on screen. Press ESC or click Close to exit.",
            bg='#2C3E50',
            fg='#BDC3C7',
            font=('Segoe UI', 10)
        )
        instructions.pack(side='left', padx=30)

        # Close button
        close_btn = tk.Button(
            info_frame,
            text="✕ Close Task",
            command=self._on_closing,
            bg='#E74C3C',
            fg='white',
            font=('Segoe UI', 11, 'bold'),
            relief='flat',
            padx=20,
            pady=8,
            cursor='hand2',
            activebackground='#C0392B'
        )
        close_btn.pack(side='right', padx=30)

        # Bind ESC key to close
        self.root.bind('<Escape>', lambda e: self._on_closing())

        # Launch the VB6 program
        try:
            print(f"\nLaunching: {self.exe_path}")
            self.process = subprocess.Popen(
                [str(self.exe_path)],
                cwd=str(self.exe_path.parent)
            )

            # Start monitoring and centering in background
            threading.Thread(target=self._monitor_and_center, daemon=True).start()

            # Start the container GUI
            self.root.mainloop()

            return True

        except Exception as e:
            if self.root:
                self.root.destroy()
            raise e

    def _monitor_and_center(self):
        """Background thread to monitor VB6 window and keep it centered"""
        try:
            import ctypes
            from ctypes import wintypes
            user32 = ctypes.windll.user32

            print("Monitoring for VB6 window...")

            # Keep looking for and centering the window
            while self.keep_running and self.process and self.process.poll() is None:
                # Search for VB6 windows
                found_windows = []

                def enum_callback(hwnd, lParam):
                    if user32.IsWindowVisible(hwnd):
                        title_length = user32.GetWindowTextLengthW(hwnd)
                        if title_length > 0:
                            title_buffer = ctypes.create_unicode_buffer(title_length + 1)
                            user32.GetWindowTextW(hwnd, title_buffer, title_length + 1)
                            title = title_buffer.value

                            class_buffer = ctypes.create_unicode_buffer(256)
                            user32.GetClassNameW(hwnd, class_buffer, 256)
                            class_name = class_buffer.value

                            rect = wintypes.RECT()
                            user32.GetWindowRect(hwnd, ctypes.byref(rect))
                            width = rect.right - rect.left
                            height = rect.bottom - rect.top

                            # Look for VB6 windows with actual size (ignore tiny splash screens < 200px)
                            if width > 200 and height > 200 and ('Thunder' in class_name or any(word in title.upper() for word in ['BART', 'PASAT', 'MIRROR'])):
                                found_windows.append({
                                    'hwnd': hwnd,
                                    'title': title,
                                    'width': width,
                                    'height': height,
                                    'left': rect.left,
                                    'top': rect.top
                                })
                    return True

                EnumWindowsProc = ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p)
                user32.EnumWindows(EnumWindowsProc(enum_callback), 0)

                # Center any found windows
                if found_windows:
                    for win in found_windows:
                        screen_width = user32.GetSystemMetrics(0)
                        screen_height = user32.GetSystemMetrics(1)

                        x = (screen_width - win['width']) // 2
                        y = (screen_height - win['height']) // 2

                        # Only move if it's not already centered (within 10 pixels)
                        if abs(win['left'] - x) > 10 or abs(win['top'] - y) > 10:
                            user32.SetWindowPos(
                                win['hwnd'], -1, x, y, 0, 0,  # -1 = HWND_TOPMOST
                                0x0001 | 0x0040  # NOSIZE | SHOWWINDOW
                            )
                            print(f"✓ Centered '{win['title']}' ({win['width']}x{win['height']}) at ({x},{y})")
                            self.hwnd = win['hwnd']

                time.sleep(0.3)

            # Process ended, close container
            if self.root:
                self.root.quit()

        except Exception as e:
            print(f"Monitor thread error: {e}")

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

    def _on_closing(self):
        """Handle window close event"""
        self.keep_running = False

        # Terminate the process if still running
        if self.process and self.process.poll() is None:
            try:
                self.process.terminate()
                time.sleep(0.5)
                if self.process.poll() is None:
                    self.process.kill()
            except:
                pass

        if self.root:
            self.root.quit()


def launch_task_in_container(task_name, exe_path, window_width=800, window_height=600):
    """
    Convenience function to launch a task in a fullscreen overlay container

    Args:
        task_name: Name of the task
        exe_path: Path to the executable
        window_width: Not used (for compatibility)
        window_height: Not used (for compatibility)

    Returns:
        bool: True if launched successfully
    """
    container = WindowContainer(task_name, exe_path, window_width, window_height)
    return container.launch_in_container()
