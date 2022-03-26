#Requires -RunAsAdministrator

Write-Host "---"
Write-Host "Starting Docker Desktop Insall"
Write-Host "... --- ..."
Write-Host "---"
Write-Host ""
$dockerInstaller = Start-Job {
    choco install docker-desktop
}
Wait-Job $dockerInstaller
Receive-Job $dockerInstaller
Write-Host ""
Write-Host "---"
Write-Host "... --- ..."
Write-Host "Ending Docker Desktop Insall"
Write-Host "---"
Write-Host ""
Write-Host ""
Write-Host "Refreshenv"
Write-Host "... --- ..."
Write-Host ""
$refEnv4 = Start-Job {
    refreshenv
}
Wait-Job $refEnv4
Receive-Job $refEnv4
Write-Host ""
Write-Host "... --- ..."
Write-Host "REFRESHED!"
Write-Host ""
Write-Host ""
Write-Host ""
