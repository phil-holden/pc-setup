param (
    [Parameter(Mandatory=$true)]
    [string]$Username
)

 md ./scripts

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/internal/createUser.sh' -OutFile "./scripts/createUser.sh"
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/internal/installShell.sh' -OutFile "./scripts/installShell.sh"
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/internal/configureShell.sh' -OutFile "./scripts/configureShell.sh"
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/scripts/internal/installTools.sh' -OutFile "./scripts/installTools.sh"

wsl -d Ubuntu -u root bash -ic "apt update; apt upgrade -y; apt autoremove -y"

wsl -d Ubuntu -u root bash -ic "./scripts/createUser.sh $Username"

wsl -d Ubuntu -u $Username bash -ic "./installShell.sh"

wsl -d Ubuntu -u $Username bash -ic "./configureShell.sh"

wsl -d Ubuntu -u $Username bash -ic "./installTools.sh"

rm ./scripts -Recurse -Force
