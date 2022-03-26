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

$gitCloneRepo = Start-Job {
    if(!($(Get-Location) -match 'wordpress$' )) {
        git clone https://github.com/mr1337alien/wordpress.git
    }
}
Wait-Job $gitCloneRepo
Receive-Job $gitCloneRepo

$refEnv = Start-Job {
    refreshenv
}
Wait-Job $refEnv
Receive-Job $refEnv
