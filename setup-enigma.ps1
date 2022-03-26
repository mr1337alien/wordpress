$gitCloneRepo = Start-Job {
    git clone https://github.com/mr1337alien/wordpress.git
}
Wait-Job $gitCloneRepo
Receive-Job $gitCloneRepo

$refEnv = Start-Job {
    refreshenv
}
Wait-Job $refEnv
Receive-Job $refEnv
