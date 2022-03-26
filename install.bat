::rem CALL START /WAIT Powershell.exe "%cd%\install-enigma.ps1" -Verb runAs
::rem powershell -ExecutionPolicy ByPass -command ". '%cd%\install-enigma.ps1' < NUL
::rem CALL START /WAIT Powershell.exe "%cd%\setup-enigma.ps1" -Verb runAs
::rem powershell -ExecutionPolicy ByPass -command ". '%cd%\setup-enigma.ps1' < NUL
CALL PowerShell.exe "%cd%\install-enigma.ps1"
