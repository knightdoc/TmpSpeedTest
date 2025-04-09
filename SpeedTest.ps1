#Creates a temporary folder on the desktop
$desktopPath = [Environment]::GetFolderPath("Desktop")
$tempFolderName = "TempFolder_{0}" -f (Get-Date -Format "yyyyMMdd_HHmmss")
$tempFolderPath = Join-Path -Path $desktopPath -ChildPath $tempFolderName
New-Item -ItemType Directory -Path $tempFolderPath -Force | Out-Null
Write-Host "Created temp folder: $tempFolderPath" -ForegroundColor Cyan

#Define download URL for Speedtest CLI (Windows 64-bit)
$downloadUrl = "https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip"
$zipFilePath = Join-Path -Path $tempFolderPath -ChildPath "speedtest.zip"

#Downloads the zip file
Write-Host "Downloading Speedtest CLI..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath

#Extracts the zip
Write-Host "Extracting Speedtest CLI..." -ForegroundColor Yellow
Expand-Archive -Path $zipFilePath -DestinationPath $tempFolderPath -Force

#Run the speed test
$speedtestExe = Get-ChildItem -Path $tempFolderPath -Filter "speedtest.exe" -Recurse | Select-Object -First 1

if ($speedtestExe) {
    Write-Host "Running Speedtest CLI..." -ForegroundColor Green
    Start-Process -FilePath $speedtestExe.FullName -NoNewWindow -Wait
} else {
    Write-Host "Speedtest executable not found!" -ForegroundColor Red
    exit
}

#Wait/ sleep 
Write-Host "Waiting 3 minutes before cleanup..." -ForegroundColor Cyan
Start-Sleep -Seconds 180

#Clean up (Delete the temp folder and contents)
Write-Host "Cleaning up: deleting temp files..." -ForegroundColor Yellow
try {
    Remove-Item -Path $tempFolderPath -Recurse -Force
    Write-Host "Cleanup complete. Temp folder deleted." -ForegroundColor Green
} catch {
    Write-Host "Error during cleanup: $_" -ForegroundColor Red
}
