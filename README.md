# TmpSpeedTest
What It Does:
Creates a temporary folder on the user's desktop with a timestamped name(editable).

Downloads the latest Ookla Speedtest CLI ZIP file into that folder.

Extracts the contents of the ZIP file.

Runs the Speedtest using the downloaded CLI tool.

Waits for 3 minutes after the test completes.

Deletes all downloaded files and removes the temporary folder.

How to Use:
Save the script with a .ps1 extension (e.g., Run-SpeedTest.ps1).

Right-click the file and select "Run with PowerShell"
or open PowerShell and run:

  .\Run-SpeedTest.ps1

Watch the test results. The temp files will be removed automatically after 3 minutes.

Notes:
The script uses Invoke-WebRequest and Expand-Archive (PowerShell 5.1+.)

No software is permanently installed—it's fully portable and self-cleaning.

You can modify the wait time or output behavior as needed.
