param (
    [Parameter(Mandatory=$true)]
    [string]$Username
)

wsl --install -d Ubuntu

wsl -d Ubuntu -u root bash -ic "apt update; apt upgrade -y; apt autoremove -y"

wsl -d Ubuntu -u root bash -ic "./internal/createUser.sh $Username"

wsl -d Ubuntu -u $Username bash -ic "./internal/installShell.sh"

wsl -d Ubuntu -u $Username bash -ic "./internal/configureShell.sh"