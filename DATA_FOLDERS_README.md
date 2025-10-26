# CAPER Suite - Data Collection Folder Setup

## Overview

This document explains the data collection folder structure for CAPER Suite and how to set it up on your system.

## Quick Setup

### Windows Users

1. Double-click `setup_data_folders.bat`
2. The script will create all necessary folders at `C:\CAPER_Data`

### All Platforms (Windows, Linux, Mac)

```bash
python setup_data_folders.py
```

This will create:
- **Windows**: `C:\CAPER_Data`
- **Linux/Mac**: `~/CAPER_Data`

## Folder Structure

```
C:\CAPER_Data\                  (or ~/CAPER_Data on Linux/Mac)
├── PASAT\                      # PASAT Standard task data
├── PASAT_7550\                 # PASAT 7550 Hz variant data
├── BART_Auto\                  # BART Automatic task data
├── BART_Adol\                  # BART Adolescent task data
├── BART_Options\               # BART Options task data
├── BART_Options_P\             # BART Options Parametric task data
├── BART_BAIT\                  # BART BAIT task data
├── Mirror_Task\                # Mirror Drawing Task data
├── BIRD_Basic\                 # BIRD Basic task data
├── Backups\                    # Automatic database backups
└── Exports\                    # Exported data files (CSV, Excel, etc.)
```

## Purpose of Each Folder

### Task-Specific Folders

Each task folder stores:
- **Database files** (.mdb) containing participant responses
- **Output files** (task-specific formats)
- **Session logs** and metadata

### Backups Folder

Contains timestamped backups of all task databases:
- Created automatically before each task run
- Format: `TaskName_Database_YYYYMMDD_HHMMSS.mdb`
- Prevents data loss from accidental overwrites

### Exports Folder

Contains exported/converted data:
- **CSV files** for statistical analysis
- **Excel files** (.xlsx) for spreadsheet viewing
- **Summary reports** and data aggregations

## Data Collection Workflow

1. **Before Running Tasks**: Ensure folders exist by running setup script
2. **During Task Execution**: Data is saved to task-specific folders
3. **After Task Completion**:
   - Automatic backup created in `Backups/`
   - Data available in task folder
4. **Data Export**: Use CAPER Suite GUI to export to `Exports/` folder

## Important Notes

### Permissions

- **Windows**: Run as Administrator if permission errors occur
- **Linux/Mac**: Ensure write permissions for home directory

### Data Security

- **Never share raw data** without participant consent
- **Backup regularly** to external storage
- **Remove identifying information** before sharing

### Task-Specific Notes

#### BART Tasks
- Store `.mdb` Microsoft Access databases
- Contain trial-by-trial balloon pump data
- Include risk-taking metrics and timing

#### PASAT Tasks
- Store `.mdb` databases with audio response data
- Include accuracy, reaction time, processing speed

#### Mirror Task
- Stores `MIRROROUT.TXT` (tab-delimited text)
- Contains trial data, mood ratings, errors
- See `CODEBOOK.TXT` for variable descriptions

#### BIRD Task
- Stores `.mdb` database with implicit association data
- Includes response times and accuracy metrics

## Troubleshooting

### "Permission Denied" Errors

**Windows**: Right-click script → "Run as Administrator"

**Linux/Mac**:
```bash
sudo python setup_data_folders.py
# or
chmod +x setup_data_folders.py
./setup_data_folders.py
```

### Folders Not Created

1. Check disk space (need at least 100 MB free)
2. Verify write permissions to C:\ (Windows) or home directory
3. Run setup script again

### Tasks Can't Find Data Folders

1. Verify folders exist: `C:\CAPER_Data` (Windows) or `~/CAPER_Data` (Linux/Mac)
2. Re-run setup script
3. Check task configuration in CAPER Suite settings

## Manual Setup

If automated setup fails, manually create:

1. Main folder: `C:\CAPER_Data` (Windows) or `~/CAPER_Data` (other)
2. Subfolders for each task (see structure above)
3. Ensure all folders have write permissions

## Data Management Best Practices

### Regular Backups
- Copy `C:\CAPER_Data` to external drive weekly
- Use cloud storage with encryption (Google Drive, Dropbox)
- Maintain 3-2-1 backup rule: 3 copies, 2 different media, 1 offsite

### Data Organization
- Use consistent participant IDs across tasks
- Document session date/time in filename or metadata
- Keep raw data separate from analyzed data

### Data Sharing
- Export to CSV/Excel for sharing with collaborators
- De-identify data (remove names, birthdates, etc.)
- Include data dictionary/codebook with exports

## Support

For issues with data folder setup:
1. Check this README first
2. Verify system permissions
3. Try manual folder creation
4. Contact CAPER Suite support with error details
