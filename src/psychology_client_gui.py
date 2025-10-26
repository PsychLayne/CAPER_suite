#!/usr/bin/env python3
"""
CAPER Suite - Retro Graphical User Interface
Fun, colorful tkinter-based UI for Psychology Research Task Launcher
"""

import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import sys
import os
from pathlib import Path
from datetime import datetime
import threading
import subprocess
import random

# Import existing backend modules
from task_manager import TaskManager
from config import SYSTEM_REQUIREMENTS


class RetroTaskCard(tk.Frame):
    """Large retro-styled card widget for displaying a single task"""

    COLORS = [
        {"bg": "#FF1493", "accent": "#FF69B4", "text": "white"},  # Hot Pink
        {"bg": "#00CED1", "accent": "#40E0D0", "text": "white"},  # Turquoise
        {"bg": "#32CD32", "accent": "#90EE90", "text": "white"},  # Lime Green
        {"bg": "#FF69B4", "accent": "#FFB6C1", "text": "white"},  # Pink
        {"bg": "#1E90FF", "accent": "#87CEEB", "text": "white"},  # Blue
        {"bg": "#9370DB", "accent": "#BA55D3", "text": "white"},  # Purple
        {"bg": "#FF6347", "accent": "#FFA07A", "text": "white"},  # Tomato
        {"bg": "#20B2AA", "accent": "#48D1CC", "text": "white"},  # Light Sea Green
    ]

    def __init__(self, parent, task_name, task_data, task_manager, color_scheme, **kwargs):
        super().__init__(parent, **kwargs)
        self.task_name = task_name
        self.task_data = task_data
        self.task_manager = task_manager
        self.color_scheme = color_scheme

        # Configure card background
        self.configure(bg=color_scheme["bg"], relief="raised", borderwidth=8)

        # Create main container with padding
        main_container = tk.Frame(self, bg=color_scheme["bg"])
        main_container.pack(fill="both", expand=True, padx=40, pady=40)

        # Task name with retro shadow effect
        name_shadow = tk.Label(main_container, text=task_name,
                              font=("Arial", 32, "bold"),
                              bg=color_scheme["bg"], fg="black")
        name_shadow.place(x=52, y=22)

        name_label = tk.Label(main_container, text=task_name,
                             font=("Arial", 32, "bold"),
                             bg=color_scheme["bg"], fg=color_scheme["text"])
        name_label.pack(pady=(20, 10))

        # Separator line
        separator = tk.Frame(main_container, bg=color_scheme["accent"], height=4)
        separator.pack(fill="x", pady=10)

        # Purpose/Description
        purpose_text = task_data.get("purpose", "")
        purpose_label = tk.Label(main_container, text=purpose_text,
                                font=("Arial", 16),
                                bg=color_scheme["bg"], fg=color_scheme["text"],
                                wraplength=700, justify="center")
        purpose_label.pack(pady=20)

        # Target population
        target_label = tk.Label(main_container,
                               text=f"Target: {task_data.get('target_population', 'N/A')}",
                               font=("Arial", 13, "italic"),
                               bg=color_scheme["bg"], fg=color_scheme["accent"])
        target_label.pack(pady=10)

        # Status indicator
        is_available = self.task_manager.check_task_availability(task_name)

        status_frame = tk.Frame(main_container, bg=color_scheme["bg"])
        status_frame.pack(pady=20)

        if is_available:
            status_text = "✓ READY TO LAUNCH ✓"
            status_fg = "#00FF00"  # Bright green
        else:
            status_text = "✗ NOT AVAILABLE ✗"
            status_fg = "#FF0000"  # Bright red

        status_label = tk.Label(status_frame, text=status_text,
                               font=("Courier", 16, "bold"),
                               bg=color_scheme["bg"], fg=status_fg)
        status_label.pack()

        # Buttons container
        button_frame = tk.Frame(main_container, bg=color_scheme["bg"])
        button_frame.pack(pady=30)

        # Launch button with retro styling
        if is_available:
            launch_btn = tk.Button(button_frame, text="▶ LAUNCH TASK",
                                  command=lambda: self._launch_task(),
                                  bg="#FFD700", fg="black",
                                  font=("Arial", 18, "bold"),
                                  relief="raised", borderwidth=5,
                                  padx=40, pady=20, cursor="hand2",
                                  activebackground="#FFA500")
            launch_btn.pack(pady=10)
        else:
            launch_btn = tk.Button(button_frame, text="✗ UNAVAILABLE",
                                  bg="#808080", fg="white",
                                  font=("Arial", 18, "bold"),
                                  relief="sunken", borderwidth=5,
                                  padx=40, pady=20, state="disabled")
            launch_btn.pack(pady=10)

        # Info button
        info_btn = tk.Button(button_frame, text="ⓘ MORE INFO",
                            command=lambda: self._show_info(),
                            bg=color_scheme["accent"], fg="white",
                            font=("Arial", 12, "bold"),
                            relief="raised", borderwidth=3,
                            padx=20, pady=10, cursor="hand2",
                            activebackground=color_scheme["bg"])
        info_btn.pack(pady=10)

    def _launch_task(self):
        """Launch the task with confirmation"""
        result = messagebox.askyesno(
            "Launch Task",
            f"Launch {self.task_name}?\n\n"
            f"Purpose: {self.task_data.get('purpose', 'N/A')}\n\n"
            "A backup will be created automatically.",
            icon='question'
        )

        if result:
            try:
                self.task_manager.run_task(self.task_name)
                messagebox.showinfo("Success", f"{self.task_name} launched successfully!")
            except Exception as e:
                messagebox.showerror("Error", f"Failed to launch task:\n{str(e)}")

    def _show_info(self):
        """Show detailed task information"""
        info = f"""Task: {self.task_name}

Description: {self.task_data.get('description', 'N/A')}

Purpose: {self.task_data.get('purpose', 'N/A')}

Target Population: {self.task_data.get('target_population', 'N/A')}

Executable: {self.task_data.get('executable', 'N/A')}
Directory: {self.task_data.get('directory', 'N/A')}
"""

        if self.task_data.get('database'):
            info += f"\nDatabase: {self.task_data['database']}"
        if self.task_data.get('output_file'):
            info += f"\nOutput File: {self.task_data['output_file']}"

        messagebox.showinfo(f"Task Information - {self.task_name}", info)


class PsychologyClientGUI:
    """Main Retro GUI application for CAPER Suite"""

    def __init__(self, root):
        self.root = root
        self.root.title("CAPER Suite - Retro Task Launcher")
        self.root.geometry("1024x768")
        self.root.minsize(1024, 768)

        # Initialize task manager
        self.task_manager = TaskManager()

        # Get all tasks from task manager
        self.TASKS = self.task_manager.get_all_tasks_dict()
        self.task_list = list(self.TASKS.items())
        self.current_task_index = 0

        # Configure style
        self.setup_styles()

        # Create main layout
        self.create_header()
        self.create_footer()  # Create footer first so counter_label exists
        self.create_carousel()  # This calls update_counter() which needs counter_label

        # Center window
        self.center_window()

        # Enable fullscreen mode
        self.root.attributes('-fullscreen', True)

        # Bind ESC key to exit fullscreen
        self.root.bind('<Escape>', self.toggle_fullscreen)

        # Bind arrow keys for navigation
        self.root.bind('<Left>', lambda e: self.prev_task())
        self.root.bind('<Right>', lambda e: self.next_task())

    def setup_styles(self):
        """Configure custom styles"""
        style = ttk.Style()
        style.theme_use('clam')

    def center_window(self):
        """Center the window on screen"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')

    def toggle_fullscreen(self, event=None):
        """Toggle fullscreen mode on/off"""
        current_state = self.root.attributes('-fullscreen')
        self.root.attributes('-fullscreen', not current_state)
        return "break"

    def create_header(self):
        """Create retro header"""
        header = tk.Frame(self.root, bg="#000000", height=80)
        header.pack(fill="x", side="top")
        header.pack_propagate(False)

        # Retro gradient effect with colored bands
        color_band1 = tk.Frame(header, bg="#FF1493", height=4)
        color_band1.pack(fill="x", side="bottom")

        color_band2 = tk.Frame(header, bg="#00CED1", height=4)
        color_band2.pack(fill="x", side="bottom")

        color_band3 = tk.Frame(header, bg="#32CD32", height=4)
        color_band3.pack(fill="x", side="bottom")

        # Title with retro computer font
        title_frame = tk.Frame(header, bg="#000000")
        title_frame.pack(expand=True)

        title = tk.Label(title_frame, text="★ CAPER SUITE ★",
                        font=("Courier", 28, "bold"),
                        bg="#000000", fg="#00FF00")
        title.pack(pady=8)

        subtitle = tk.Label(title_frame,
                           text=">> PSYCHOLOGY RESEARCH TASK LAUNCHER <<",
                           font=("Courier", 10, "bold"),
                           bg="#000000", fg="#00CED1")
        subtitle.pack()

    def create_carousel(self):
        """Create task carousel with navigation"""
        # Main carousel container
        carousel_container = tk.Frame(self.root, bg="#1a1a1a")
        carousel_container.pack(fill="both", expand=True)

        # Navigation container
        nav_frame = tk.Frame(carousel_container, bg="#1a1a1a")
        nav_frame.pack(fill="both", expand=True)

        # Left arrow button
        left_arrow = tk.Button(nav_frame, text="◀",
                              command=self.prev_task,
                              font=("Arial", 40, "bold"),
                              bg="#FF1493", fg="white",
                              relief="raised", borderwidth=8,
                              cursor="hand2",
                              activebackground="#FF69B4",
                              width=3, height=15)
        left_arrow.pack(side="left", padx=10, fill="y")

        # Task card container (center)
        self.card_container = tk.Frame(nav_frame, bg="#1a1a1a")
        self.card_container.pack(side="left", fill="both", expand=True)

        # Right arrow button
        right_arrow = tk.Button(nav_frame, text="▶",
                               command=self.next_task,
                               font=("Arial", 40, "bold"),
                               bg="#00CED1", fg="white",
                               relief="raised", borderwidth=8,
                               cursor="hand2",
                               activebackground="#40E0D0",
                               width=3, height=15)
        right_arrow.pack(side="right", padx=10, fill="y")

        # Display first task
        self.update_carousel()

    def create_footer(self):
        """Create retro footer"""
        footer = tk.Frame(self.root, bg="#000000", height=40)
        footer.pack(fill="x", side="bottom")
        footer.pack_propagate(False)

        # Colored bands
        color_band1 = tk.Frame(footer, bg="#32CD32", height=4)
        color_band1.pack(fill="x", side="top")

        color_band2 = tk.Frame(footer, bg="#00CED1", height=4)
        color_band2.pack(fill="x", side="top")

        color_band3 = tk.Frame(footer, bg="#FF1493", height=4)
        color_band3.pack(fill="x", side="top")

        footer_content = tk.Frame(footer, bg="#000000")
        footer_content.pack(fill="both", expand=True)

        # Status message
        self.status_label = tk.Label(footer_content,
                                    text="Use ◀ ▶ arrows or click buttons | Press ESC to exit fullscreen",
                                    font=("Courier", 9, "bold"),
                                    bg="#000000", fg="#00FF00")
        self.status_label.pack(side="left", padx=15, pady=2)

        # Task counter
        self.counter_label = tk.Label(footer_content, text="",
                                     font=("Courier", 9, "bold"),
                                     bg="#000000", fg="#FFD700")
        self.counter_label.pack(side="right", padx=15, pady=2)
        self.update_counter()

    def update_carousel(self):
        """Update the carousel to show the current task"""
        # Clear current card
        for widget in self.card_container.winfo_children():
            widget.destroy()

        # Get current task
        if self.task_list:
            task_name, task_data = self.task_list[self.current_task_index]

            # Choose color scheme based on task index
            color_scheme = RetroTaskCard.COLORS[self.current_task_index % len(RetroTaskCard.COLORS)]

            # Create and display task card
            card = RetroTaskCard(self.card_container, task_name, task_data,
                               self.task_manager, color_scheme)
            card.pack(fill="both", expand=True, padx=20, pady=20)

        self.update_counter()

    def next_task(self):
        """Navigate to next task"""
        if self.task_list:
            self.current_task_index = (self.current_task_index + 1) % len(self.task_list)
            self.update_carousel()

    def prev_task(self):
        """Navigate to previous task"""
        if self.task_list:
            self.current_task_index = (self.current_task_index - 1) % len(self.task_list)
            self.update_carousel()

    def update_counter(self):
        """Update the task counter display"""
        if self.task_list:
            total = len(self.task_list)
            current = self.current_task_index + 1
            self.counter_label.config(text=f"Task {current} of {total}")


def main():
    """Main entry point - for standalone use without launcher"""
    try:
        root = tk.Tk()
        app = PsychologyClientGUI(root)
        root.mainloop()
    except Exception as e:
        # Show error in a message box
        import traceback
        error_msg = f"Error starting CAPER Suite GUI:\n\n{str(e)}\n\n{traceback.format_exc()}"
        try:
            import tkinter.messagebox as mb
            error_root = tk.Tk()
            error_root.withdraw()
            mb.showerror("CAPER Suite - Error", error_msg)
            error_root.destroy()
        except:
            # If tkinter fails, print to console
            print(error_msg)
            input("\nPress Enter to exit...")
        raise


if __name__ == "__main__":
    main()
