#Requires -RunAsAdministrator

Write-Host "---"
Write-Host "Starting Git Insall"
Write-Host "... --- ..."
Write-Host "---"
Write-Host ""
$gitInstaller = Start-Job {
    choco install git.install
}
Wait-Job $gitInstaller
Receive-Job $gitInstaller
Write-Host ""
Write-Host "---"
Write-Host "... --- ..."
Write-Host "Ending Gradle Insall"
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