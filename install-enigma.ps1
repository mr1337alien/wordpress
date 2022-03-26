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

$gitInstaller = Start-Job {
    choco install git.install
}
Wait-Job $gitInstaller
Receive-Job $gitInstaller

$refEnv2 = Start-Job {
    refreshenv
}
Wait-Job $refEnv2
Receive-Job $refEnv2

$nodejsInstaller = Start-Job {
    choco install nodejs
}
Wait-Job $nodejsInstaller
Receive-Job $nodejsInstaller


$refEnv3 = Start-Job {
    refreshenv
}
Wait-Job $refEnv3
Receive-Job $refEnv3

$dockerInstaller = Start-Job {
    choco install docker-desktop
}
Wait-Job $dockerInstaller
Receive-Job $dockerInstaller

$refEnv4 = Start-Job {
    refreshenv
}
Wait-Job $refEnv4
Receive-Job $refEnv4

$gradleInstaller = Start-Job {
    choco install gradle
}
Wait-Job $gradleInstaller
Receive-Job $gradleInstaller

$refEnv5 = Start-Job {
    refreshenv
}
Wait-Job $refEnv5
Receive-Job $refEnv5
