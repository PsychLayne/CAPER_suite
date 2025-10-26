#!/usr/bin/env python3
"""
CAPER Suite - Data Collection Folder Setup Script
Creates necessary folders for data collection on Windows C: drive or current system
"""

import os
import sys
from pathlib import Path


def create_data_folders():
    """Create all necessary data collection folders"""

    # Determine base path based on OS
    if sys.platform == 'win32':
        # Windows: Use C:\CAPER_Data
        base_path = Path("C:/CAPER_Data")
    else:
        # Linux/Mac: Use home directory
        base_path = Path.home() / "CAPER_Data"

    print("=" * 50)
    print("CAPER Suite - Data Collection Setup")
    print("=" * 50)
    print()

    # Create main data directory
    print(f"Creating main data directory at: {base_path}")
    base_path.mkdir(exist_ok=True)
    print(f"✓ Created {base_path}")
    print()

    # Task subdirectories
    task_folders = [
        "PASAT",
        "PASAT_7550",
        "BART_Auto",
        "BART_Adol",
        "BART_Options",
        "BART_Options_P",
        "BART_BAIT",
        "Mirror_Task",
        "BIRD_Basic",
        "Backups",
        "Exports"
    ]

    print("Creating task subdirectories...")
    for folder in task_folders:
        folder_path = base_path / folder
        folder_path.mkdir(exist_ok=True)
        print(f"  ✓ {folder_path}")

    print()
    print("=" * 50)
    print("Setup Complete!")
    print("=" * 50)
    print()
    print(f"All data collection folders have been created.")
    print(f"Data will be stored in: {base_path}")
    print()
    print("Folder Structure:")
    print(f"  {base_path}/")
    for folder in task_folders:
        print(f"    ├── {folder}/")
    print()


if __name__ == "__main__":
    try:
        create_data_folders()
    except Exception as e:
        print(f"Error creating folders: {e}")
        sys.exit(1)
