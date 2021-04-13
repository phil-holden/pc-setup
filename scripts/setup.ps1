function Install-Chocolatey {
    if (-Not $env:ChocolateyInstall) {
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

Install-Chocolatey

choco upgrade git --yes
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.gitconfig' -OutFile (Join-Path $env:USERPROFILE '.gitconfig')


# install choco packages
# - general tools
choco upgrade 7zip --yes
choco upgrade greenshot --yes
choco upgrade notepadplusplus --yes
choco upgrade zoomit --yes
choco upgrade powershell-core --yes --pre
choco upgrade microsoft-windows-terminal --pre 
choco upgrade cascadiacode

# - dev tools
choco upgrade azure-cli --yes
choco upgrade azure-data-studio --yes
choco upgrade docker-desktop --yes
choco upgrade nuget.commandline --yes
choco upgrade terraform --yes
choco upgrade vscode --yes
