function Install-Chocolatey {
    if (-Not $env:ChocolateyInstall) {
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        
        refreshenv
    }
}

Install-Chocolatey

choco upgrade git --yes
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.gitconfig' -OutFile (Join-Path $env:USERPROFILE '.gitconfig')

if (-Not (Test-Path -Path (Join-Path $env:USERPROFILE '.poshthemes'))) {
    New-Item -ItemType Directory -Path (Join-Path $env:USERPROFILE '.poshthemes')
}
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.agnostercustom.omp.json' -OutFile (Join-Path $env:USERPROFILE '.poshthemes/.agnostercustom.omp.json')

# install choco packages
# - general tools
choco upgrade 7zip --yes
choco upgrade greenshot --yes
choco upgrade notepadplusplus --yes
choco upgrade zoomit --yes
choco upgrade powershell-core --yes --pre
choco upgrade microsoft-windows-terminal --yes --pre
choco upgrade cascadiacode --yes
choco upgrade cascadiacodepl --yes

# - wsl2 (reboot required)
Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
choco upgrade wsl2 --yes

# - configure WSL2 settings
$wtFolder = Get-ChildItem -Directory -Path (Join-Path $env:LocalAppData 'Packages') -Filter "*Microsoft.WindowsTerminal*"
Remove-Item -Path (Join-Path $env:LocalAppData 'Packages' $wtFolder.Name 'LocalState') -Force -Recurse

if (-Not (Test-Path -Path (Join-Path $env:USERPROFILE '.terminal'))) {
    New-Item -ItemType Directory -Path (Join-Path $env:USERPROFILE '.terminal')
}

New-Item -ItemType SymbolicLink -Path (Join-Path $env:LocalAppData 'Packages' $wtFolder.Name 'LocalState') -Target (Join-Path $env:USERPROFILE '.terminal')

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/terminalSettings.json' -OutFile (Join-Path $env:USERPROFILE '.terminal/settings.json')


# - dev tools
choco upgrade azure-cli --yes
choco upgrade azure-data-studio --yes
choco upgrade docker-desktop --yes
choco upgrade nuget.commandline --yes
choco upgrade terraform --yes
choco upgrade vscode --yes

# install vscode extensions
refreshenv
code --install-extension ms-azuretools.vscode-azureterraform
