#Requires -RunAsAdministrator

$npmInstall = Start-Job {
    npm install
}
Wait-Job $npmInstall
Receive-Job $npmInstall

$npmRunBuildDev = Start-Job {
    npm run build:dev
}
Wait-Job $npmRunBuildDev
Receive-Job $npmRunBuildDev

$npmRunEnvStart = Start-Job {
    npm run env:start
}
Wait-Job $npmRunEnvStart
Receive-Job $npmRunEnvStart


$npmRunEnvInstall = Start-Job {
    npm run env:install
}
Wait-Job $npmRunEnvInstall
Receive-Job $npmRunEnvInstall

Write-Out "Check http://localhost:8889 for lokal testing - Server is running now!"