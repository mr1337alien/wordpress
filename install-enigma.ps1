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

& "$PSScriptRoot\install-enigma-choco.ps1"
& "$PSScriptRoot\install-enigma-git.ps1"
& "$PSScriptRoot\install-enigma-nodejs.ps1"
& "$PSScriptRoot\install-enigma-gradle.ps1"
& "$PSScriptRoot\install-enigma-docker.ps1"

Pause

& "$PSScriptRoot\setup-enigma.ps1"

Pause