#!/usr/bin/env python3
"""
CAPER Suite Psychology Client
Main launcher for all psychology tasks

This unified client provides easy access to all CAPER psychology tasks:
- PASAT (Auditory Processing Tests)
- BART (Risk-Taking Assessments)
- Mirror Task (Motor Coordination)

Usage: python psychology_client.py
"""

import sys
import os
from pathlib import Path

# Add current directory to path
sys.path.insert(0, str(Path(__file__).parent))

import config
from task_manager import TaskManager


class PsychologyClient:
    """Main client interface for CAPER psychology tasks"""

    def __init__(self):
        self.task_manager = TaskManager()
        self.running = True

    def display_banner(self):
        """Display welcome banner"""
        print("\n" + "=" * 80)
        print(" " * 20 + "CAPER SUITE - PSYCHOLOGY CLIENT")
        print(" " * 15 + "Unified Task Launcher for Research Psychology")
        print("=" * 80)
        print("\nWelcome! This client provides easy access to all psychology tasks.")
        print("Select a task from the menu below to get started.\n")

    def display_menu(self):
        """Display main menu"""
        print("\n" + "-" * 80)
        print("MAIN MENU")
        print("-" * 80)
        print("\n[1]  List All Tasks")
        print("[2]  Launch a Task")
        print("[3]  View Task Information")
        print("[4]  System Information")
        print("[5]  Verify System Requirements")
        print("[6]  Check VB6 Dependencies (Windows)")
        print("[7]  Help")
        print("[Q]  Quit")
        print()

    def display_task_selection_menu(self):
        """Display task selection menu"""
        print("\n" + "-" * 80)
        print("SELECT A TASK TO LAUNCH")
        print("-" * 80)

        for category, task_ids in config.TASK_CATEGORIES.items():
            print(f"\n{category}:")
            for task_id in task_ids:
                task = config.PSYCHOLOGY_TASKS[task_id]
                status = "✓" if config.task_exists(task_id) else "✗"
                print(f"  [{task_id}] {status} {task['name']}")

        print("\n[B] Back to Main Menu")
        print()

    def display_help(self):
        """Display help information"""
        print("\n" + "=" * 80)
        print("HELP - CAPER SUITE PSYCHOLOGY CLIENT")
        print("=" * 80)
        print("\nThis client allows you to easily run psychology research tasks.")
        print("\nAVAILABLE TASKS:")
        print("  - PASAT: Auditory processing and working memory tests")
        print("  - BART: Risk-taking behavior assessments")
        print("  - Mirror Task: Motor coordination and learning")
        print("\nHOW TO USE:")
        print("  1. Select 'List All Tasks' to see available tasks")
        print("  2. Select 'Launch a Task' to run a specific task")
        print("  3. Follow on-screen instructions for each task")
        print("  4. Data is automatically saved to task directories")
        print("\nDATA MANAGEMENT:")
        print(f"  - Task data is saved in each task's directory")
        print(f"  - Backups are created automatically in: {config.BACKUP_DIR}")
        print(f"  - Export options available for data analysis")
        print("\nSYSTEM REQUIREMENTS:")
        print("  - Windows XP or later (native)")
        print("  - Linux/Mac with Wine installed")
        print("  - Sound card for audio tasks")
        print("  - Display: 800x600 minimum")
        print("\nTROUBLESHOOTING:")
        print("  - If tasks fail to start with 'module not found' error:")
        print("    Run 'Check VB6 Dependencies' from the main menu")
        print("  - Windows Defender may flag VB6 tasks as false positives")
        print("    See QUICK_FIX_WINDOWS_DEFENDER.txt for solution")
        print("\nSUPPORT:")
        print("  - For task-specific instructions, see .doc files in task directories")
        print("  - For technical issues, check system requirements")
        print("  - See README.md for comprehensive troubleshooting guide")
        print("=" * 80 + "\n")

    def handle_list_tasks(self):
        """Handle list all tasks option"""
        self.task_manager.list_all_tasks()
        input("Press Enter to continue...")

    def handle_launch_task(self):
        """Handle launch task option"""
        while True:
            self.display_task_selection_menu()
            choice = input("Select task number (or B to go back): ").strip().upper()

            if choice == 'B':
                break

            if choice in config.PSYCHOLOGY_TASKS:
                # Show task info first
                if not self.task_manager.display_task_info(choice):
                    print("\nError: Task not available.")
                    input("Press Enter to continue...")
                    continue

                # Confirm launch
                confirm = input("\nLaunch this task? (Y/N): ").strip().upper()
                if confirm == 'Y':
                    success = self.task_manager.launch_task(choice)
                    if success:
                        input("\nPress Enter to continue...")
                    else:
                        input("\nFailed to launch task. Press Enter to continue...")
                break
            else:
                print(f"Invalid choice: {choice}")
                input("Press Enter to try again...")

    def handle_task_info(self):
        """Handle view task information option"""
        self.display_task_selection_menu()
        choice = input("Select task number (or B to go back): ").strip().upper()

        if choice == 'B':
            return

        if choice in config.PSYCHOLOGY_TASKS:
            self.task_manager.display_task_info(choice)
            input("Press Enter to continue...")
        else:
            print(f"Invalid choice: {choice}")
            input("Press Enter to continue...")

    def handle_system_info(self):
        """Handle system information option"""
        self.task_manager.view_system_info()
        input("Press Enter to continue...")

    def handle_verify_system(self):
        """Handle verify system requirements option"""
        self.task_manager.run_all_checks()
        input("Press Enter to continue...")

    def handle_check_vb6_dependencies(self):
        """Handle check VB6 dependencies option"""
        import platform
        if platform.system() != "Windows":
            print("\n" + "=" * 80)
            print("VB6 DEPENDENCY CHECKER - NON-WINDOWS SYSTEM")
            print("=" * 80)
            print("\nThis check is only needed on Windows.")
            print("On Linux/Mac, Wine provides the necessary VB6 runtime libraries.")
            print("\nIf you're having issues with Wine:")
            print("  - Ensure Wine is installed: wine --version")
            print("  - Try running a task to see if it works")
            print("=" * 80 + "\n")
            input("Press Enter to continue...")
            return

        print("\n" + "=" * 80)
        print("CHECKING VB6 DEPENDENCIES")
        print("=" * 80)
        print("\nRunning dependency checker...")
        print("This will check if all required DLLs are installed.\n")

        try:
            import subprocess
            result = subprocess.run(
                [sys.executable, "scripts/check_vb6_dependencies.py"],
                cwd=str(Path(__file__).parent),
                capture_output=False
            )

            if result.returncode != 0:
                print("\n" + "=" * 80)
                print("NEXT STEPS")
                print("=" * 80)
                print("\nTo install missing dependencies:")
                print("  1. Open Command Prompt as Administrator")
                print("  2. Navigate to the CAPER_suite directory")
                print("  3. Run: python scripts/install_vb6_runtime.py")
                print("\nOr see QUICK_FIX_MODULE_NOT_FOUND.txt for detailed instructions.")
                print("=" * 80)

        except Exception as e:
            print(f"\nError running dependency checker: {e}")
            print("\nYou can manually run:")
            print("  python scripts/check_vb6_dependencies.py")

        print()
        input("Press Enter to continue...")

    def run(self):
        """Main application loop"""
        self.display_banner()

        # Run initial system check
        print("Running initial system check...")
        issues = self.task_manager.verify_system_requirements()
        if issues:
            print("\n⚠ Warning: Some issues detected:")
            for issue in issues[:3]:  # Show first 3 issues
                print(f"  {issue}")
            if len(issues) > 3:
                print(f"  ... and {len(issues) - 3} more")
            print("\nYou can still use the client, but some tasks may not work.")
            print("Use 'Verify System Requirements' from the menu for details.\n")
        else:
            print("✓ System check passed!\n")

        while self.running:
            self.display_menu()
            choice = input("Enter your choice: ").strip().upper()

            if choice == '1':
                self.handle_list_tasks()
            elif choice == '2':
                self.handle_launch_task()
            elif choice == '3':
                self.handle_task_info()
            elif choice == '4':
                self.handle_system_info()
            elif choice == '5':
                self.handle_verify_system()
            elif choice == '6':
                self.handle_check_vb6_dependencies()
            elif choice == '7':
                self.display_help()
            elif choice == 'Q':
                print("\nThank you for using CAPER Suite Psychology Client!")
                print("Goodbye!\n")
                self.running = False
            else:
                print(f"\nInvalid choice: {choice}")
                print("Please enter a number from the menu or 'Q' to quit.")
                input("Press Enter to continue...")


def main():
    """Main entry point"""
    try:
        client = PsychologyClient()
        client.run()
    except KeyboardInterrupt:
        print("\n\nInterrupted by user. Exiting...")
        sys.exit(0)
    except Exception as e:
        print(f"\nError: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
