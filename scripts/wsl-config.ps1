param (
    [Parameter(Mandatory=$true)]
    [ValidateNotNull]
    [string]$username
)

wsl --install -d Ubuntu

wsl -d Ubuntu -u root bash -ic "apt update; apt upgrade -y; apt autoremove -y"

wsl -d Ubuntu -u root bash -ic "./internal/createUser.sh $username"
