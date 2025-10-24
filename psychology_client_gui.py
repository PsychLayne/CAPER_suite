#!/usr/bin/env python3
"""
CAPER Suite - Graphical User Interface
Professional tkinter-based UI for Psychology Research Task Launcher
"""

import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import sys
import os
from pathlib import Path
from datetime import datetime
import threading
import subprocess

# Import existing backend modules
from task_manager import TaskManager
from config import SYSTEM_REQUIREMENTS


class ModernButton(tk.Canvas):
    """Modern, flat-design button with hover effects"""

    def __init__(self, parent, text, command, bg_color="#4A90E2", hover_color="#357ABD",
                 text_color="white", width=200, height=50, **kwargs):
        super().__init__(parent, width=width, height=height, highlightthickness=0, **kwargs)

        self.bg_color = bg_color
        self.hover_color = hover_color
        self.text_color = text_color
        self.command = command
        self.text = text

        # Draw button
        self.rect = self.create_rectangle(0, 0, width, height, fill=bg_color, outline="")
        self.text_id = self.create_text(width//2, height//2, text=text, fill=text_color,
                                        font=("Segoe UI", 10, "bold"))

        # Bind events
        self.bind("<Enter>", self._on_enter)
        self.bind("<Leave>", self._on_leave)
        self.bind("<Button-1>", self._on_click)

    def _on_enter(self, event):
        self.itemconfig(self.rect, fill=self.hover_color)

    def _on_leave(self, event):
        self.itemconfig(self.rect, fill=self.bg_color)

    def _on_click(self, event):
        if self.command:
            self.command()


class TaskCard(tk.Frame):
    """Card widget for displaying a task with status and launch button"""

    def __init__(self, parent, task_name, task_data, task_manager, **kwargs):
        super().__init__(parent, relief="raised", borderwidth=1, **kwargs)
        self.task_name = task_name
        self.task_data = task_data
        self.task_manager = task_manager

        # Configure card background
        self.configure(bg="white", padx=15, pady=15)

        # Task name
        name_label = tk.Label(self, text=task_name, font=("Segoe UI", 12, "bold"),
                             bg="white", fg="#2C3E50")
        name_label.pack(anchor="w")

        # Purpose
        purpose_label = tk.Label(self, text=task_data.get("purpose", ""),
                                font=("Segoe UI", 9), bg="white", fg="#7F8C8D",
                                wraplength=250, justify="left")
        purpose_label.pack(anchor="w", pady=(5, 10))

        # Status indicator
        is_available = self.task_manager.check_task_availability(task_name)
        status_frame = tk.Frame(self, bg="white")
        status_frame.pack(anchor="w", pady=5)

        status_color = "#27AE60" if is_available else "#E74C3C"
        status_text = "✓ Ready" if is_available else "✗ Not Found"

        status_dot = tk.Label(status_frame, text="●", font=("Segoe UI", 12),
                             fg=status_color, bg="white")
        status_dot.pack(side="left", padx=(0, 5))

        status_label = tk.Label(status_frame, text=status_text,
                               font=("Segoe UI", 9), bg="white", fg=status_color)
        status_label.pack(side="left")

        # Launch button
        launch_btn = tk.Button(self, text="Launch Task",
                              command=lambda: self._launch_task(),
                              bg="#4A90E2", fg="white", font=("Segoe UI", 9, "bold"),
                              relief="flat", padx=20, pady=8, cursor="hand2",
                              activebackground="#357ABD", activeforeground="white")
        launch_btn.pack(pady=(10, 0), fill="x")

        if not is_available:
            launch_btn.config(state="disabled", bg="#BDC3C7")

        # Info button
        info_btn = tk.Button(self, text="ℹ Info",
                            command=lambda: self._show_info(),
                            bg="white", fg="#4A90E2", font=("Segoe UI", 8),
                            relief="flat", cursor="hand2",
                            activebackground="#ECF0F1", activeforeground="#4A90E2")
        info_btn.pack(pady=(5, 0))

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
    """Main GUI application for CAPER Suite"""

    def __init__(self, root):
        self.root = root
        self.root.title("CAPER Suite - Psychology Research Task Launcher")
        self.root.geometry("1100x700")
        self.root.minsize(900, 600)

        # Initialize task manager
        self.task_manager = TaskManager()

        # Get all tasks from task manager
        self.TASKS = self.task_manager.get_all_tasks_dict()

        # Configure style
        self.setup_styles()

        # Create main layout
        self.create_header()
        self.create_main_content()
        self.create_footer()

        # Center window
        self.center_window()

    def setup_styles(self):
        """Configure custom styles"""
        style = ttk.Style()
        style.theme_use('clam')

        # Configure notebook (tabs)
        style.configure('TNotebook', background='#ECF0F1', borderwidth=0)
        style.configure('TNotebook.Tab', padding=[20, 10], font=('Segoe UI', 10))
        style.map('TNotebook.Tab', background=[('selected', '#4A90E2')],
                 foreground=[('selected', 'white')])

    def center_window(self):
        """Center the window on screen"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')

    def create_header(self):
        """Create application header"""
        header = tk.Frame(self.root, bg="#2C3E50", height=80)
        header.pack(fill="x", side="top")
        header.pack_propagate(False)

        # Title
        title = tk.Label(header, text="🧠 CAPER Suite",
                        font=("Segoe UI", 24, "bold"),
                        bg="#2C3E50", fg="white")
        title.pack(side="left", padx=30, pady=20)

        # Subtitle
        subtitle = tk.Label(header,
                           text="Comprehensive Assessment Platform for Experimental Research",
                           font=("Segoe UI", 10), bg="#2C3E50", fg="#BDC3C7")
        subtitle.pack(side="left", padx=(0, 30))

        # System status
        self.system_status_label = tk.Label(header, text="",
                                           font=("Segoe UI", 9),
                                           bg="#2C3E50", fg="#27AE60")
        self.system_status_label.pack(side="right", padx=30)
        self.update_system_status()

    def create_main_content(self):
        """Create main content area with tabs"""
        # Notebook for tabs
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(fill="both", expand=True, padx=10, pady=10)

        # Create tabs
        self.create_tasks_tab()
        self.create_system_tab()
        self.create_data_tab()
        self.create_help_tab()

    def create_tasks_tab(self):
        """Create tasks browser tab"""
        tasks_frame = tk.Frame(self.notebook, bg="#ECF0F1")
        self.notebook.add(tasks_frame, text="📋 Tasks")

        # Create scrollable canvas
        canvas = tk.Canvas(tasks_frame, bg="#ECF0F1", highlightthickness=0)
        scrollbar = ttk.Scrollbar(tasks_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = tk.Frame(canvas, bg="#ECF0F1")

        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )

        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)

        # Organize tasks by category
        categories = {
            "🎧 Auditory Processing Tests": {
                "color": "#9B59B6",
                "tasks": ["PASAT - Standard", "PASAT - 7550"]
            },
            "🎈 Risk-Taking Assessments": {
                "color": "#E74C3C",
                "tasks": ["BART - Automatic", "BART - Adolescent", "BART - Options",
                         "BART - Options P", "BART - BAIT"]
            },
            "🎯 Motor Coordination": {
                "color": "#3498DB",
                "tasks": ["Mirror Task"]
            }
        }

        row = 0
        for category_name, category_data in categories.items():
            # Category header
            category_frame = tk.Frame(scrollable_frame, bg=category_data["color"], height=40)
            category_frame.pack(fill="x", pady=(10 if row > 0 else 0, 0))
            category_frame.pack_propagate(False)

            category_label = tk.Label(category_frame, text=category_name,
                                     font=("Segoe UI", 14, "bold"),
                                     bg=category_data["color"], fg="white")
            category_label.pack(side="left", padx=20, pady=10)

            # Task cards container
            cards_frame = tk.Frame(scrollable_frame, bg="#ECF0F1")
            cards_frame.pack(fill="x", padx=20, pady=10)

            col = 0
            for task_name in category_data["tasks"]:
                if task_name in self.TASKS:
                    card = TaskCard(cards_frame, task_name, self.TASKS[task_name],
                                  self.task_manager, width=280)
                    card.grid(row=row, column=col, padx=10, pady=10, sticky="nsew")
                    col += 1
                    if col >= 3:  # 3 cards per row
                        col = 0
                        row += 1

            row += 1

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # Enable mousewheel scrolling
        def _on_mousewheel(event):
            canvas.yview_scroll(int(-1*(event.delta/120)), "units")
        canvas.bind_all("<MouseWheel>", _on_mousewheel)

    def create_system_tab(self):
        """Create system information tab"""
        system_frame = tk.Frame(self.notebook, bg="white")
        self.notebook.add(system_frame, text="⚙️ System")

        # Title
        title = tk.Label(system_frame, text="System Information",
                        font=("Segoe UI", 18, "bold"), bg="white", fg="#2C3E50")
        title.pack(pady=20)

        # System info display
        info_frame = tk.Frame(system_frame, bg="white")
        info_frame.pack(fill="both", expand=True, padx=40, pady=20)

        # Get system info
        system_info = self.task_manager.get_system_info()

        # Display info
        info_text = scrolledtext.ScrolledText(info_frame, height=20, font=("Consolas", 10),
                                             bg="#F8F9FA", relief="flat", padx=20, pady=20)
        info_text.pack(fill="both", expand=True)

        info_content = f"""
╔══════════════════════════════════════════════════════════════╗
║                    CAPER SUITE SYSTEM STATUS                  ║
╚══════════════════════════════════════════════════════════════╝

Operating System:       {system_info['os']}
Platform:              {system_info['platform']}
Python Version:        {system_info['python_version']}

Wine Installed:        {'✓ Yes' if system_info.get('wine_installed') else '✗ No'}
Wine Version:          {system_info.get('wine_version', 'N/A')}

╔══════════════════════════════════════════════════════════════╗
║                       TASK AVAILABILITY                       ║
╚══════════════════════════════════════════════════════════════╝

"""

        for task_name in self.TASKS:
            is_available = self.task_manager.check_task_availability(task_name)
            status = "✓" if is_available else "✗"
            info_content += f"{status} {task_name:<25} {'Ready' if is_available else 'Not Found'}\n"

        info_content += f"""
╔══════════════════════════════════════════════════════════════╗
║                    SYSTEM REQUIREMENTS                        ║
╚══════════════════════════════════════════════════════════════╝

Minimum Requirements:
  • Python: {SYSTEM_REQUIREMENTS['python_version']}+
  • RAM: {SYSTEM_REQUIREMENTS['min_ram_mb']} MB
  • Display: {SYSTEM_REQUIREMENTS['min_screen_width']}x{SYSTEM_REQUIREMENTS['min_screen_height']}
  • Wine: {SYSTEM_REQUIREMENTS['wine_version']}+ (Linux/Mac)

"""

        info_text.insert("1.0", info_content)
        info_text.config(state="disabled")

        # Verify button
        verify_btn = tk.Button(system_frame, text="Verify System Requirements",
                              command=self.verify_system,
                              bg="#27AE60", fg="white", font=("Segoe UI", 11, "bold"),
                              relief="flat", padx=30, pady=12, cursor="hand2",
                              activebackground="#229954", activeforeground="white")
        verify_btn.pack(pady=20)

    def create_data_tab(self):
        """Create data management tab"""
        data_frame = tk.Frame(self.notebook, bg="white")
        self.notebook.add(data_frame, text="💾 Data")

        # Title
        title = tk.Label(data_frame, text="Data Management",
                        font=("Segoe UI", 18, "bold"), bg="white", fg="#2C3E50")
        title.pack(pady=20)

        # Info
        info = tk.Label(data_frame,
                       text="Manage task data, backups, and exports",
                       font=("Segoe UI", 10), bg="white", fg="#7F8C8D")
        info.pack(pady=(0, 20))

        # Buttons frame
        buttons_frame = tk.Frame(data_frame, bg="white")
        buttons_frame.pack(pady=20)

        # Backup button
        backup_btn = tk.Button(buttons_frame, text="📦 View Backups",
                              command=self.view_backups,
                              bg="#3498DB", fg="white", font=("Segoe UI", 11, "bold"),
                              relief="flat", padx=30, pady=12, cursor="hand2",
                              width=20, activebackground="#2980B9")
        backup_btn.grid(row=0, column=0, padx=10, pady=10)

        # Export button
        export_btn = tk.Button(buttons_frame, text="📊 Export Data",
                              command=self.export_data,
                              bg="#9B59B6", fg="white", font=("Segoe UI", 11, "bold"),
                              relief="flat", padx=30, pady=12, cursor="hand2",
                              width=20, activebackground="#8E44AD")
        export_btn.grid(row=0, column=1, padx=10, pady=10)

        # Open data folder button
        open_btn = tk.Button(buttons_frame, text="📁 Open Data Folder",
                            command=self.open_data_folder,
                            bg="#E67E22", fg="white", font=("Segoe UI", 11, "bold"),
                            relief="flat", padx=30, pady=12, cursor="hand2",
                            width=20, activebackground="#D35400")
        open_btn.grid(row=1, column=0, padx=10, pady=10)

        # Open backup folder button
        backup_folder_btn = tk.Button(buttons_frame, text="📂 Open Backup Folder",
                                     command=self.open_backup_folder,
                                     bg="#16A085", fg="white", font=("Segoe UI", 11, "bold"),
                                     relief="flat", padx=30, pady=12, cursor="hand2",
                                     width=20, activebackground="#138D75")
        backup_folder_btn.grid(row=1, column=1, padx=10, pady=10)

        # Data info display
        info_frame = tk.Frame(data_frame, bg="#F8F9FA", relief="flat")
        info_frame.pack(fill="both", expand=True, padx=40, pady=20)

        self.data_info_text = scrolledtext.ScrolledText(info_frame, height=15,
                                                       font=("Consolas", 9),
                                                       bg="#F8F9FA", relief="flat",
                                                       padx=20, pady=20)
        self.data_info_text.pack(fill="both", expand=True)
        self.update_data_info()

    def create_help_tab(self):
        """Create help and documentation tab"""
        help_frame = tk.Frame(self.notebook, bg="white")
        self.notebook.add(help_frame, text="❓ Help")

        # Title
        title = tk.Label(help_frame, text="Help & Documentation",
                        font=("Segoe UI", 18, "bold"), bg="white", fg="#2C3E50")
        title.pack(pady=20)

        # Help content
        help_text = scrolledtext.ScrolledText(help_frame, font=("Segoe UI", 10),
                                             bg="white", relief="flat", padx=30, pady=20,
                                             wrap="word")
        help_text.pack(fill="both", expand=True, padx=20, pady=(0, 20))

        help_content = """
🧠 WELCOME TO CAPER SUITE

The Comprehensive Assessment Platform for Experimental Research (CAPER) provides a unified interface for launching and managing psychology research tasks.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 USING THE TASKS TAB

1. Browse tasks organized by category:
   • Auditory Processing Tests (PASAT variants)
   • Risk-Taking Assessments (BART variants)
   • Motor Coordination (Mirror Task)

2. Each task card shows:
   • Task name and purpose
   • Availability status (✓ Ready or ✗ Not Found)
   • Launch button (when task is available)
   • Info button for detailed information

3. To launch a task:
   • Click the "Launch Task" button
   • Confirm in the dialog
   • A backup is automatically created before launch

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚙️ SYSTEM REQUIREMENTS

Minimum Requirements:
  • Python 3.7 or higher
  • 512 MB RAM
  • 800x600 display resolution
  • Sound card (for auditory tasks)
  • Windows XP+ OR Linux/Mac with Wine 5.0+

Use the "Verify System Requirements" button in the System tab to check compatibility.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💾 DATA MANAGEMENT

Automatic Backups:
  • Created before each task launch
  • Stored with timestamp: taskname_database_YYYYMMDD_HHMMSS
  • Located in data_backup/ folder

Data Formats:
  • Most tasks: Microsoft Access (.mdb) databases
  • Mirror Task: Tab-delimited text file (MIRROROUT.TXT)

Export Options:
  • Excel (.xlsx) format
  • CSV format
  • Original database format

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 TASK DESCRIPTIONS

🎧 PASAT (Paced Auditory Serial Addition Test)
   Purpose: Assess cognitive function, processing speed, and working memory
   Population: Adults and adolescents

🎈 BART (Balloon Analogue Risk Task)
   Purpose: Measure risk-taking behavior and decision-making
   Variants: Automatic, Adolescent, Options, Options P, BAIT

🎯 Mirror Task
   Purpose: Assess motor learning and coordination
   Output: Performance metrics, mood ratings, error counts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔧 TROUBLESHOOTING

Task Not Found:
  • Verify task files exist in their directories
  • Check that executable files (.exe) are present
  • Run system verification in System tab

Launch Failures:
  • On Linux/Mac: Ensure Wine is installed (wine --version)
  • Check task database files aren't locked/in-use
  • Review backup folder for data preservation

Data Export Issues:
  • Ensure sufficient disk space
  • Close any open database files
  • Check write permissions on output directories

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📞 SUPPORT

For issues, questions, or contributions:
  • Check system requirements first
  • Verify all task files are present
  • Review the documentation in the project README

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Version: 2.0
© 2024 CAPER Suite - Psychology Research Tools
"""

        help_text.insert("1.0", help_content)
        help_text.config(state="disabled")

    def create_footer(self):
        """Create application footer"""
        footer = tk.Frame(self.root, bg="#34495E", height=40)
        footer.pack(fill="x", side="bottom")
        footer.pack_propagate(False)

        # Status message
        self.status_label = tk.Label(footer, text="Ready",
                                    font=("Segoe UI", 9),
                                    bg="#34495E", fg="white")
        self.status_label.pack(side="left", padx=20)

        # Version
        version_label = tk.Label(footer, text="CAPER Suite v2.0",
                                font=("Segoe UI", 9),
                                bg="#34495E", fg="#BDC3C7")
        version_label.pack(side="right", padx=20)

    def update_system_status(self):
        """Update system status in header"""
        system_info = self.task_manager.get_system_info()
        available_tasks = sum(1 for task in self.TASKS.values() if task.get('available', False))
        total_tasks = len(self.TASKS)

        status_text = f"✓ {available_tasks}/{total_tasks} Tasks Ready | {system_info['os']}"
        self.system_status_label.config(text=status_text)

    def update_data_info(self):
        """Update data information display"""
        info = f"""
╔══════════════════════════════════════════════════════════════╗
║                      DATA INFORMATION                         ║
╚══════════════════════════════════════════════════════════════╝

Backup Directory: {Path('data_backup').absolute()}
Output Directory: {Path('data_output').absolute()}

Recent Backups:
"""

        # List recent backups
        backup_dir = Path('data_backup')
        if backup_dir.exists():
            backups = sorted(backup_dir.glob('*'), key=lambda p: p.stat().st_mtime, reverse=True)
            if backups:
                for backup in backups[:10]:  # Show last 10
                    mtime = datetime.fromtimestamp(backup.stat().st_mtime)
                    size = backup.stat().st_size / 1024  # KB
                    info += f"  • {backup.name:<50} {size:>8.1f} KB  {mtime.strftime('%Y-%m-%d %H:%M')}\n"
            else:
                info += "  (No backups found)\n"
        else:
            info += "  (Backup directory not found)\n"

        self.data_info_text.delete("1.0", "end")
        self.data_info_text.insert("1.0", info)

    def verify_system(self):
        """Verify system requirements"""
        self.set_status("Verifying system requirements...")
        issues = self.task_manager.verify_system_requirements()

        if not issues:
            message = "System Verification Results:\n\n✓ All requirements met!\n✓ All tasks are available!"
            messagebox.showinfo("System Verification", message)
            self.set_status("System verification passed")
        else:
            message = "System Verification Results:\n\n⚠ Issues detected:\n\n"
            for issue in issues:
                message += f"  • {issue}\n"
            messagebox.showwarning("System Verification", message)
            self.set_status("System verification found issues")

    def view_backups(self):
        """View backup files"""
        backup_dir = Path('data_backup')
        if not backup_dir.exists():
            messagebox.showinfo("No Backups", "No backup directory found.")
            return

        backups = list(backup_dir.glob('*'))
        if not backups:
            messagebox.showinfo("No Backups", "No backup files found.")
            return

        # Show backup list
        message = f"Found {len(backups)} backup files.\n\nOpening backup folder..."
        messagebox.showinfo("Backups", message)
        self.open_backup_folder()

    def export_data(self):
        """Export task data"""
        self.set_status("Exporting data...")
        try:
            result = self.task_manager.export_all_data()
            messagebox.showinfo("Export Complete",
                              f"Data exported successfully!\n\n{result}")
            self.set_status("Data export complete")
        except Exception as e:
            messagebox.showerror("Export Error", f"Failed to export data:\n{str(e)}")
            self.set_status("Data export failed")

    def open_data_folder(self):
        """Open data output folder"""
        data_dir = Path('data_output')
        data_dir.mkdir(exist_ok=True)
        self._open_folder(data_dir)
        self.set_status(f"Opened {data_dir.absolute()}")

    def open_backup_folder(self):
        """Open backup folder"""
        backup_dir = Path('data_backup')
        backup_dir.mkdir(exist_ok=True)
        self._open_folder(backup_dir)
        self.set_status(f"Opened {backup_dir.absolute()}")

    def _open_folder(self, path):
        """Open a folder in the system file manager"""
        import platform
        import subprocess

        system = platform.system()
        try:
            if system == "Windows":
                os.startfile(path)
            elif system == "Darwin":  # macOS
                subprocess.Popen(["open", path])
            else:  # Linux
                subprocess.Popen(["xdg-open", path])
        except Exception as e:
            messagebox.showerror("Error", f"Could not open folder:\n{str(e)}")

    def set_status(self, message):
        """Update status bar message"""
        self.status_label.config(text=message)
        self.root.update_idletasks()


def main():
    """Main entry point"""
    root = tk.Tk()
    app = PsychologyClientGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()
