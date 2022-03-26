#Requires -RunAsAdministrator

Set-ExecutionPolicy Unrestricted

Write-Host "---"
Write-Host "Starting policy adjustments + Chocolatey Install"
Write-Host "... --- ..."
Write-Host "---"
Write-Host ""
$chocoInstaller = Start-Job {
    if(!$(Get-ExecutionPolicy) -eq "Unrestricted") {
        Set-ExecutionPolicy Bypass -Scope Process
    }
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
Wait-Job $chocoInstaller
Receive-Job $chocoInstaller
Write-Host ""
Write-Host "---"
Write-Host "... --- ..."
Write-Host "Ending policy adjustments + Chocolatey Install"
Write-Host "---"
Write-Host ""
$chocoGuiInstaller = Start-Job {
    refreshenv
    choco feature enable -n=allowGlobalConfirmation
    choco install chocolateygui
}
Wait-Job $chocoGuiInstaller
Receive-Job $chocoGuiInstaller
Write-Host "---"
Write-Host "Refreshenv"
Write-Host "... --- ..."
Write-Host ""
$refEnv = Start-Job {
    choco feature enable -n=allowGlobalConfirmation
    choco install enable -n=allowGlobalConfirmation
    refreshenv
}
Wait-Job $refEnv
Receive-Job $refEnv
Write-Host ""
Write-Host "... --- ..."
Write-Host "REFRESHED!"
Write-Host "---"
Write-Host ""
Write-Host ""
