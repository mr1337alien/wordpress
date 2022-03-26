$chocoInstaller = Start-Job {
    if(!$(Get-ExecutionPolicy) -eq "Unrestricted")) {
        Set-ExecutionPolicy Bypass -Scope Process
    }
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
 }
Wait-Job $chocoInstaller
Receive-Job $chocoInstaller

$refEnv = Start-Job {
    refreshenv
}
Wait-Job $refEnv
Receive-Job $refEnv

$nodejsInstaller = Start-Job {
    choco install nodejs
}
Wait-Job $nodejsInstaller
Receive-Job $nodejsInstaller

$dockerInstaller = Start-Job {
    choco install docker-desktop
}
Wait-Job $dockerInstaller
Receive-Job $dockerInstaller

$refEnv2 = Start-Job {
    refreshenv
}
Wait-Job $refEnv2
Receive-Job $refEnv2