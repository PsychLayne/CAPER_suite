"""
CAPER Suite Psychology Tasks Configuration
Defines all available psychology tasks and their properties
"""

import os
from pathlib import Path

# Base directory
BASE_DIR = Path(__file__).parent.absolute()

# Available Psychology Tasks
PSYCHOLOGY_TASKS = {
    "1": {
        "name": "PASAT - Standard",
        "description": "Paced Auditory Serial Addition Test (Standard)",
        "directory": "PASAT",
        "executable": "PASAT_Stnd.exe",
        "database": "PASAT_Stnd.mdb",
        "instructions": "PASAT_Stnd_Instructions.doc",
        "purpose": "Tests auditory processing speed and working memory",
        "target_population": "General adults"
    },
    "2": {
        "name": "PASAT - 7550",
        "description": "Paced Auditory Serial Addition Test (7550 Hz variant)",
        "directory": "PASAT_7550",
        "executable": "PASAT_7550.exe",
        "database": "PASAT_7550.mdb",
        "instructions": "PASAT_7550_Instructions.doc",
        "purpose": "Tests auditory processing speed and working memory",
        "target_population": "General adults"
    },
    "3": {
        "name": "BART - Automatic",
        "description": "Balloon Analogue Risk Task (Automatic Version)",
        "directory": "bart_auto",
        "executable": "BART_Auto.exe",
        "database": "BART_Auto.mdb",
        "instructions": "BART_Auto.doc",
        "purpose": "Risk-taking and decision-making assessment (automated)",
        "target_population": "General population"
    },
    "4": {
        "name": "BART - Adolescent",
        "description": "Balloon Analogue Risk Task (Adolescent Version)",
        "directory": "bart_adol",
        "executable": "BART_Adol.exe",
        "database": "Bart_Adol.mdb",
        "instructions": "BART_Adol.doc",
        "purpose": "Risk-taking and decision-making assessment",
        "target_population": "Adolescents"
    },
    "5": {
        "name": "BART - Options",
        "description": "Balloon Analogue Risk Task (Options Version)",
        "directory": "bart_options",
        "executable": "BART_Options.exe",
        "database": "BART_Options.mdb",
        "instructions": "BART_Options.doc",
        "purpose": "Risk-taking with choice variants",
        "target_population": "General population"
    },
    "6": {
        "name": "BART - Options P",
        "description": "Balloon Analogue Risk Task (Parametric Options)",
        "directory": "BART_Options_P",
        "executable": "BART_Options_P.exe",
        "database": "BART_Options_P.mdb",
        "instructions": "BART_Options_P.doc",
        "purpose": "Parametric risk-taking assessment",
        "target_population": "General population"
    },
    "7": {
        "name": "BART - BAIT",
        "description": "Balloon Analogue Risk Task (Adaptive BAIT Version)",
        "directory": "BART_BAIT",
        "executable": "BART_BAIT.exe",
        "database": "BART_BAIT.mdb",
        "instructions": None,
        "purpose": "Adaptive risk-taking assessment",
        "target_population": "General population"
    },
    "8": {
        "name": "Mirror Task",
        "description": "Mirror Drawing Task (Motor Coordination)",
        "directory": "MT",
        "executable": "Mirror b5.exe",
        "database": None,
        "output_file": "MIRROROUT.TXT",
        "codebook": "CODEBOOK.TXT",
        "instructions": None,
        "purpose": "Motor coordination and learning/adaptation assessment",
        "target_population": "General population"
    }
}

# Task Categories
TASK_CATEGORIES = {
    "Auditory Processing": ["1", "2"],
    "Risk-Taking Assessment": ["3", "4", "5", "6", "7"],
    "Motor Coordination": ["8"]
}

# System Requirements
SYSTEM_REQUIREMENTS = {
    "os": "Windows XP or later (or Wine on Linux/Mac)",
    "architecture": "x86 (32-bit compatible)",
    "display": "800x600 minimum resolution",
    "audio": "Sound card required",
    "runtime": [
        "Visual Basic 6.0 Runtime (msvbvm60.dll)",
        "Microsoft Jet 3.5 database engine",
        "Windows Common Controls (MSCOMCTL.OCX)"
    ]
}

# Data Output Configuration
DATA_OUTPUT_DIR = BASE_DIR / "data_output"
BACKUP_DIR = BASE_DIR / "data_backup"

# Ensure output directories exist
DATA_OUTPUT_DIR.mkdir(exist_ok=True)
BACKUP_DIR.mkdir(exist_ok=True)


def get_task_path(task_id):
    """Get the full path to a task's directory"""
    if task_id not in PSYCHOLOGY_TASKS:
        return None

    task = PSYCHOLOGY_TASKS[task_id]
    return BASE_DIR / task["directory"]


def get_executable_path(task_id):
    """Get the full path to a task's executable"""
    if task_id not in PSYCHOLOGY_TASKS:
        return None

    task = PSYCHOLOGY_TASKS[task_id]
    task_dir = BASE_DIR / task["directory"]
    return task_dir / task["executable"]


def get_database_path(task_id):
    """Get the full path to a task's database"""
    if task_id not in PSYCHOLOGY_TASKS:
        return None

    task = PSYCHOLOGY_TASKS[task_id]
    if task.get("database") is None:
        return None

    task_dir = BASE_DIR / task["directory"]
    return task_dir / task["database"]


def task_exists(task_id):
    """Check if a task's executable exists"""
    exe_path = get_executable_path(task_id)
    if exe_path is None:
        return False
    return exe_path.exists()


def get_all_task_ids():
    """Get a list of all task IDs"""
    return sorted(PSYCHOLOGY_TASKS.keys())


def get_task_by_category(category):
    """Get all tasks in a specific category"""
    if category not in TASK_CATEGORIES:
        return []
    return TASK_CATEGORIES[category]
