Set-ExecutionPolicy Bypass -Scope Process -Force; 

if (-not $env:ChocolateyInstall) {
    # Download and install choco 
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# install choco packages
# - general tools
choco upgrade 7zip
choco upgrade greenshot
choco upgrade notepadplusplus
choco upgrade zoomit

# - dev tools
choco upgrade azure-cli
choco upgrade azure-data-studio
choco upgrade docker-desktop
choco upgrade git
choco upgrade nuget.commandline
choco upgrade terraform
choco upgrade vscode

refreshenv

# - powershell
choco upgrade powershell-core
choco upgrade poshgit

# clone additional scripts
git init
git remote add origin https://github.com/phil-holden/pc-setup.git
git branch --set-upstream-to=origin/main
git pull


# install vscode extensions
