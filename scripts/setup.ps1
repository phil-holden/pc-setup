[CmdletBinding()]
param (
    [Parameter()]
    [Switch]
    $UseLocalConfig
)

function Install-Chocolatey {
    if (-Not $env:ChocolateyInstall) {
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        refreshenv
    }
}

function Create-Directory {
    param(
        [string]$Path
    )

    if (-Not (Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path
    }
}

Install-Chocolatey

choco upgrade git --yes
if ($UseLocalConfig) {
    Copy-Item -Path "$PSScriptRoot/../config/.gitconfig" -Destination (Join-Path $env:USERPROFILE '.gitconfig')
}
else {
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.gitconfig' -OutFile (Join-Path $env:USERPROFILE '.gitconfig')
}

Create-Directory -Path (Join-Path $env:USERPROFILE '.poshthemes')

if ($UseLocalConfig) {
    Copy-Item -Path "$PSScriptRoot/../config/.agnostercustom.omp.json" -Destination (Join-Path $env:USERPROFILE '.poshthemes/.agnostercustom.omp.json')
}
else {
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.agnostercustom.omp.json' -OutFile (Join-Path $env:USERPROFILE '.poshthemes/.agnostercustom.omp.json')
}

# install choco packages
# - general tools
choco upgrade 7zip --yes
choco upgrade cascadiacode --yes
choco upgrade cascadiacodepl --yes
choco upgrade cascadia-code-nerd-font --yes
choco upgrade drawio --yes
choco upgrade greenshot --yes
choco upgrade notepadplusplus --yes
choco upgrade powershell-core --yes
choco upgrade zoomit --yes
choco install oh-my-posh

$windowsBuild = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "ReleaseId").ReleaseId

# if we're on a 'decent' Windows build we can run WindowsTerminal and WSL2
if ($windowsBuild -ge 1903) {
    # - wsl2 (reboot required)
    Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
    choco upgrade wsl2 --yes

    # - install / configure Windows Terminal
    choco upgrade microsoft-windows-terminal --yes

    $destination = "$($env:LOCALAPPDATA)/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
    if ($UseLocalConfig) {
        Copy-Item -Path "$PSScriptRoot/../config/terminalSettings.json" -Destination "$destination/settings.json"
        Copy-Item -Path "$PSScriptRoot/../config/terminalState.json" -Destination "$destination/state.json"
    }
    else {
        Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/terminalSettings.json' -OutFile "$destination/settings.json"
        Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/terminalState.json' -OutFile "$destination/state.json"
    }
}
else {
    # on an older Windows build we'll drop back to running 'cmder'
    choco upgrade cmder --yes

    refreshenv

    if ($UseLocalConfig) {
        Copy-Item -Path "$PSScriptRoot/../config/cmderSettings.xml" -Desintation (Join-Path $env:ConEmuDir 'ConEmu.xml')
    }
    else {
        Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/cmderSettings.xml' -OutFile (Join-Path $env:ConEmuDir 'ConEmu.xml')
    }
}

# - dev tools
choco upgrade azure-cli --yes
# choco upgrade azure-data-studio --yes
# choco upgrade azure-functions-core-tools --yes
choco upgrade azurestorageexplorer --yes
# choco upgrade docker-desktop --yes
choco upgrade dotnetcore-sdk --yes
# choco upgrade nuget.commandline --yes
choco upgrade postman --yes
choco upgrade terraform --yes
choco upgrade vscode --yes
choco upgrade oh-my-posh --yes

# install vscode extensions
refreshenv
code --install-extension hashicorp.terraform
code --install-extension ms-vscode.powershell
code --install-extension eamodio.gitlens
code --install-extension github.github-vscode-theme
code --install-extension ms-dotnettools.csharp
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension ms-azure-devops.azure-pipelines
code --install-extension ms-dotnettools.csharp
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension redhat.vscode-yaml
code --install-extension ms-vscode-remote.remote-wsl
