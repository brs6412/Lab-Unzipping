# Lab Unzipper Script

## Overview

This PowerShell script automates the extraction of lab files from your Downloads directory. It identifies lab zip files based on a provided lab number, unzips them, and handles nested zip files located within the extracted folder (but only one level deep). It also removes the original zip files after extraction.

## Features

- Prompts for a lab number (e.g., '1' for Lab 1) to identify the correct zip file.
- Unzips the main lab folder and any zip files within it, without going into nested subdirectories.
- Checks if the main folder has already been unzipped and skips re-extracting if it exists.
- Automatically removes zip files after extraction.
- Counts the total number of files extracted.

## Requirements

- PowerShell 5.1 or later
- A properly structured zip file in your `Downloads` folder named in the format: `Lab <number> Download <date> <time>.zip`

## Usage

1. Clone or download this script to your local machine.
2. Open PowerShell.
3. Navigate to the directory containing the script.
4. Run the script by typing:

   ```powershell
   .\LabUnzipper.ps1
