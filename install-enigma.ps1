#at top of script
if (!
    #current role
    (New-Object Security.Principal.WindowsPrincipal(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    #is admin?
    )).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
) {
    #elevate script and exit current non-elevated runtime
    Start-Process `
        -FilePath 'powershell' `
        -ArgumentList (
            #flatten to single array
            '-File', $MyInvocation.MyCommand.Source, $args `
            | %{ $_ }
        ) `
        -Verb RunAs
    exit
}

#example program, this will be ran as admin
$args

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
Write-Host "---"
Write-Host "Refreshenv"
Write-Host "... --- ..."
Write-Host ""
$refEnv = Start-Job {
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
Write-Host "Ending Git Insall"
Write-Host "---"
Write-Host ""
Write-Host "Refreshenv"
Write-Host "... --- ..."
Write-Host ""
$refEnv2 = Start-Job {
    refreshenv
}
Wait-Job $refEnv2
Receive-Job $refEnv2
Write-Host ""
Write-Host "... --- ..."
Write-Host "REFRESHED!"
Write-Host "---"
Write-Host ""
Write-Host ""
Write-Host ""
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
Write-Host ""
Write-Host ""
Write-Host ""
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
Powershell.exe "$PSScriptRoot\setup-enigma.ps1"

Pause