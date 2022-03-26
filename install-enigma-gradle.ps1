#Requires -RunAsAdministrator

Write-Host "---"
Write-Host "Starting Gradle Insall"
Write-Host "... --- ..."
Write-Host "---"
Write-Host ""
$gradleInstaller = Start-Job {
    choco install gradle
}
Wait-Job $gradleInstaller
Receive-Job $gradleInstaller
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
$refEnv5 = Start-Job {
    refreshenv
}
Wait-Job $refEnv5
Receive-Job $refEnv5
Write-Host ""
Write-Host "... --- ..."
Write-Host "REFRESHED!"
Write-Host ""
Write-Host ""
Write-Host ""
