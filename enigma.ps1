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