#Requires -RunAsAdministrator

Write-Host "---"
Write-Host "Starting nodejs Insall"
Write-Host "... --- ..."
Write-Host "---"
Write-Host ""
$nodejsInstaller = Start-Job {
    choco install nodejs
}
Wait-Job $nodejsInstaller
Receive-Job $nodejsInstaller
Write-Host ""
Write-Host "---"
Write-Host "... --- ..."
Write-Host "Ending nodejs Insall"
Write-Host "---"
Write-Host ""
Write-Host ""
Write-Host "Refreshenv"
Write-Host "... --- ..."
Write-Host ""
$refEnv3 = Start-Job {
    refreshenv
}
Wait-Job $refEnv3
Receive-Job $refEnv3
Write-Host ""
Write-Host "... --- ..."
Write-Host "REFRESHED!"
Write-Host "---"
