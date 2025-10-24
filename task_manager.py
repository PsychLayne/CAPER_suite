"""
Task Manager for CAPER Suite Psychology Tasks
Handles task execution, verification, and data management
"""

import os
import sys
import subprocess
import platform
import shutil
from pathlib import Path
from datetime import datetime
import config


class TaskManager:
    """Manages psychology task execution and data"""

    def __init__(self):
        self.platform = platform.system()
        self.is_windows = self.platform == "Windows"

    def verify_system_requirements(self):
        """Verify that the system meets the requirements"""
        issues = []

        # Check platform
        if not self.is_windows:
            # Check if Wine is available
            wine_available = shutil.which("wine") is not None
            if not wine_available:
                issues.append("Wine is required to run Windows applications on Linux/Mac")
                issues.append("Install Wine: https://www.winehq.org/")

        # Check if tasks exist
        missing_tasks = []
        for task_id in config.get_all_task_ids():
            if not config.task_exists(task_id):
                task = config.PSYCHOLOGY_TASKS[task_id]
                missing_tasks.append(f"  - {task['name']} ({task['directory']}/{task['executable']})")

        if missing_tasks:
            issues.append("Missing task executables:")
            issues.extend(missing_tasks)

        return issues

    def list_all_tasks(self):
        """List all available psychology tasks"""
        print("\n" + "=" * 80)
        print("CAPER SUITE - AVAILABLE PSYCHOLOGY TASKS")
        print("=" * 80 + "\n")

        for category, task_ids in config.TASK_CATEGORIES.items():
            print(f"\n{category}:")
            print("-" * 40)
            for task_id in task_ids:
                task = config.PSYCHOLOGY_TASKS[task_id]
                status = "✓" if config.task_exists(task_id) else "✗"
                print(f"  [{task_id}] {status} {task['name']}")
                print(f"      {task['description']}")
                print(f"      Purpose: {task['purpose']}")
                print(f"      Target: {task['target_population']}")
                print()

        print("=" * 80 + "\n")

    def display_task_info(self, task_id):
        """Display detailed information about a specific task"""
        if task_id not in config.PSYCHOLOGY_TASKS:
            print(f"Error: Task ID '{task_id}' not found.")
            return False

        task = config.PSYCHOLOGY_TASKS[task_id]
        exists = config.task_exists(task_id)

        print("\n" + "=" * 80)
        print(f"TASK INFORMATION: {task['name']}")
        print("=" * 80)
        print(f"\nDescription:  {task['description']}")
        print(f"Purpose:      {task['purpose']}")
        print(f"Target:       {task['target_population']}")
        print(f"\nDirectory:    {task['directory']}")
        print(f"Executable:   {task['executable']}")
        print(f"Status:       {'Available ✓' if exists else 'Missing ✗'}")

        if task.get('database'):
            db_path = config.get_database_path(task_id)
            db_exists = db_path and db_path.exists()
            print(f"Database:     {task['database']} {'✓' if db_exists else '(will be created)'}")

        if task.get('output_file'):
            print(f"Output File:  {task['output_file']}")

        if task.get('instructions'):
            print(f"Instructions: {task['instructions']}")

        print("=" * 80 + "\n")
        return exists

    def launch_task(self, task_id):
        """Launch a psychology task"""
        if task_id not in config.PSYCHOLOGY_TASKS:
            print(f"Error: Task ID '{task_id}' not found.")
            return False

        task = config.PSYCHOLOGY_TASKS[task_id]
        exe_path = config.get_executable_path(task_id)

        if not exe_path or not exe_path.exists():
            print(f"Error: Task executable not found: {exe_path}")
            return False

        print(f"\nLaunching: {task['name']}")
        print(f"Executable: {exe_path}")

        # Create backup of database before running (if it exists)
        self._backup_task_data(task_id)

        try:
            if self.is_windows:
                # Windows: Direct execution
                process = subprocess.Popen([str(exe_path)], cwd=str(exe_path.parent))

                # Give the process a moment to start and check for immediate failures
                import time
                time.sleep(0.5)

                # Check if process is still running
                if process.poll() is not None:
                    # Process terminated immediately - likely a DLL error
                    print(f"\n✗ Task failed to start!")
                    print(f"\nThis is likely caused by missing Visual Basic 6.0 runtime libraries.")
                    print(f"\nCommon error: 'System Error &H8007007E - Module not found'")
                    print(f"\nTo fix this:")
                    print(f"  1. Check dependencies: python scripts/check_vb6_dependencies.py")
                    print(f"  2. Install VB6 Runtime: python scripts/install_vb6_runtime.py (as Administrator)")
                    print(f"\nSee QUICK_FIX_MODULE_NOT_FOUND.txt for detailed instructions.")
                    return False

                print(f"\n✓ Task launched successfully!")
                print(f"The task is now running in a separate window.")
                print(f"Data will be saved to: {exe_path.parent}")
            else:
                # Linux/Mac: Use Wine
                wine_path = shutil.which("wine")
                if not wine_path:
                    print("Error: Wine not found. Please install Wine to run Windows applications.")
                    return False

                subprocess.Popen([wine_path, str(exe_path)], cwd=str(exe_path.parent))
                print(f"\n✓ Task launched successfully with Wine!")
                print(f"The task is now running in a separate window.")
                print(f"Data will be saved to: {exe_path.parent}")

            # Display post-run instructions
            print(f"\nNOTE: After completing the task:")
            print(f"  1. Data will be automatically saved")
            if task.get('database'):
                print(f"  2. Check the database: {task['database']}")
            if task.get('output_file'):
                print(f"  2. Check the output file: {task['output_file']}")
            print(f"  3. Backups are stored in: {config.BACKUP_DIR}")

            return True

        except FileNotFoundError as e:
            print(f"\n✗ Error launching task: {e}")
            print(f"\nThe executable was not found or cannot be executed.")
            return False
        except PermissionError as e:
            print(f"\n✗ Error launching task: Permission denied")
            print(f"\nPlease check file permissions for: {exe_path}")
            return False
        except OSError as e:
            # OSError code 0xC000007B or similar indicates DLL issues
            print(f"\n✗ Error launching task: {e}")
            print(f"\nThis is likely caused by missing system libraries.")
            print(f"\nTo fix this:")
            print(f"  1. Check dependencies: python scripts/check_vb6_dependencies.py")
            print(f"  2. Install VB6 Runtime: python scripts/install_vb6_runtime.py (as Administrator)")
            print(f"\nSee QUICK_FIX_MODULE_NOT_FOUND.txt for detailed instructions.")
            return False
        except Exception as e:
            print(f"\n✗ Error launching task: {e}")
            print(f"\nIf you see 'module not found' or similar errors:")
            print(f"  Run: python scripts/check_vb6_dependencies.py")
            return False

    def _backup_task_data(self, task_id):
        """Create a backup of task data before running"""
        task = config.PSYCHOLOGY_TASKS[task_id]

        # Backup database if it exists
        if task.get('database'):
            db_path = config.get_database_path(task_id)
            if db_path and db_path.exists():
                timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                backup_name = f"{task['directory']}_{task['database']}_{timestamp}"
                backup_path = config.BACKUP_DIR / backup_name

                try:
                    shutil.copy2(db_path, backup_path)
                    print(f"✓ Backed up database to: {backup_path}")
                except Exception as e:
                    print(f"Warning: Could not backup database: {e}")

        # Backup output file if it exists
        if task.get('output_file'):
            output_path = config.get_task_path(task_id) / task['output_file']
            if output_path.exists():
                timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                backup_name = f"{task['directory']}_{task['output_file']}_{timestamp}"
                backup_path = config.BACKUP_DIR / backup_name

                try:
                    shutil.copy2(output_path, backup_path)
                    print(f"✓ Backed up output file to: {backup_path}")
                except Exception as e:
                    print(f"Warning: Could not backup output file: {e}")

    def export_task_data(self, task_id, export_format="txt"):
        """Export task data to a specified format"""
        if task_id not in config.PSYCHOLOGY_TASKS:
            print(f"Error: Task ID '{task_id}' not found.")
            return False

        task = config.PSYCHOLOGY_TASKS[task_id]
        db_path = config.get_database_path(task_id)

        if not db_path or not db_path.exists():
            print(f"Error: Database not found: {db_path}")
            return False

        print(f"\nExporting data from: {task['name']}")
        print(f"Database: {db_path}")

        # Note: Actual database export would require pyodbc or similar
        # This is a placeholder for the functionality
        print(f"\nNote: Database export requires additional setup.")
        print(f"To access .mdb files:")
        print(f"  1. On Windows: Use Microsoft Access")
        print(f"  2. On Linux: Use mdbtools (mdb-export)")
        print(f"  3. On Mac: Use mdbtools via Homebrew")
        print(f"\nAlternatively, the tasks themselves save data automatically.")

        return True

    def view_system_info(self):
        """Display system information"""
        print("\n" + "=" * 80)
        print("SYSTEM INFORMATION")
        print("=" * 80)
        print(f"\nOperating System: {platform.system()} {platform.release()}")
        print(f"Architecture:     {platform.machine()}")
        print(f"Python Version:   {sys.version.split()[0]}")

        if not self.is_windows:
            wine_path = shutil.which("wine")
            if wine_path:
                print(f"Wine:             Installed at {wine_path}")
            else:
                print(f"Wine:             NOT INSTALLED (required for running tasks)")

        print(f"\nCAPER Suite Location: {config.BASE_DIR}")
        print(f"Data Output:          {config.DATA_OUTPUT_DIR}")
        print(f"Backup Directory:     {config.BACKUP_DIR}")

        # Check which tasks are available
        available_tasks = sum(1 for task_id in config.get_all_task_ids() if config.task_exists(task_id))
        total_tasks = len(config.PSYCHOLOGY_TASKS)
        print(f"\nAvailable Tasks:      {available_tasks}/{total_tasks}")

        print("\n" + "=" * 80 + "\n")

    def run_all_checks(self):
        """Run all system checks and display results"""
        print("\n" + "=" * 80)
        print("SYSTEM VERIFICATION")
        print("=" * 80 + "\n")

        issues = self.verify_system_requirements()

        if not issues:
            print("✓ All system requirements met!")
            print("✓ All tasks are available!")
            print("\nYou're ready to run psychology tasks.\n")
            return True
        else:
            print("⚠ Issues detected:\n")
            for issue in issues:
                print(f"  {issue}")
            print("\nPlease resolve these issues before running tasks.\n")
            return False

    # GUI Helper Methods
    def get_system_info(self):
        """Get system information as a dictionary (for GUI)"""
        wine_version = "N/A"
        wine_installed = False

        if not self.is_windows:
            wine_path = shutil.which("wine")
            if wine_path:
                wine_installed = True
                try:
                    result = subprocess.run(["wine", "--version"],
                                          capture_output=True, text=True, timeout=5)
                    wine_version = result.stdout.strip()
                except:
                    wine_version = "Installed (version unknown)"

        return {
            "os": f"{platform.system()} {platform.release()}",
            "platform": platform.system(),
            "architecture": platform.machine(),
            "python_version": sys.version.split()[0],
            "wine_installed": wine_installed,
            "wine_version": wine_version
        }

    def check_task_availability(self, task_name):
        """Check if a task is available by name (for GUI)"""
        # Find task ID by name
        task_id = self._get_task_id_by_name(task_name)
        if task_id:
            return config.task_exists(task_id)
        return False

    def run_task(self, task_name):
        """Run a task by name (for GUI)"""
        task_id = self._get_task_id_by_name(task_name)
        if task_id:
            return self.launch_task(task_id)
        raise ValueError(f"Task '{task_name}' not found")

    def _get_task_id_by_name(self, task_name):
        """Get task ID from task name"""
        for task_id, task in config.PSYCHOLOGY_TASKS.items():
            if task["name"] == task_name:
                return task_id
        return None

    def get_all_tasks_dict(self):
        """Get all tasks as a dictionary with names as keys (for GUI)"""
        tasks = {}
        for task_id, task in config.PSYCHOLOGY_TASKS.items():
            tasks[task["name"]] = {
                **task,
                "task_id": task_id,
                "available": config.task_exists(task_id)
            }
        return tasks

    def export_all_data(self):
        """Export all task data (for GUI)"""
        exported = []
        for task_id in config.get_all_task_ids():
            task = config.PSYCHOLOGY_TASKS[task_id]
            db_path = config.get_database_path(task_id)
            if db_path and db_path.exists():
                # Copy database to output folder
                output_path = config.DATA_OUTPUT_DIR / f"{task['name']}_{task['database']}"
                shutil.copy2(db_path, output_path)
                exported.append(f"{task['name']}: {output_path}")

            # Handle text output files
            if task.get('output_file'):
                output_file = config.get_task_path(task_id) / task['output_file']
                if output_file.exists():
                    dest_path = config.DATA_OUTPUT_DIR / f"{task['name']}_{task['output_file']}"
                    shutil.copy2(output_file, dest_path)
                    exported.append(f"{task['name']}: {dest_path}")

        if exported:
            return "\n".join(exported)
        else:
            return "No data files found to export."
