#Requires -RunAsAdministrator

$curFolder = $PSScriptRoot
$endsWithBool = $curFolder.EndsWith("wordpress")
$endsWithBool
if(!$endsWithBool) {
    Write-Host "---"
    Write-Host "Starting Git Clone"
    Write-Host "... --- ..."
    Write-Host "---"
    Write-Host ""
    $gitCloneRepo = Start-Job {
        git clone https://github.com/mr1337alien/wordpress.git
    }
    Wait-Job $gitCloneRepo
    Receive-Job $gitCloneRepo
    Write-Host ""
    Write-Host "---"
    Write-Host "... --- ..."
    Write-Host "Ending Git Clone"
    Write-Host "---"
    Write-Host ""
    Write-Host "---"
    Write-Host "Refreshenv"
    Write-Host "... --- ..."
    Write-Host ""
    $refEnv6 = Start-Job {
        refreshenv
    }
    Wait-Job $refEnv6
    Receive-Job $refEnv6
    Write-Host ""
    Write-Host "... --- ..."
    Write-Host "REFRESHED!"
    Write-Host "---"
    Write-Host ""
    Write-Host ""
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "... --- ..."
    Write-Host "Nothing to do, everything is already checked out..."
    Write-Host "---"
    Write-Host ""
    Write-Host ""
    Write-Host ""
}
