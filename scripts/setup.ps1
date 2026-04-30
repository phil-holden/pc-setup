[CmdletBinding()]
param (
    [Parameter()]
    [Switch]
    $UseLocalConfig
)

# function Install-Chocolatey {
#     if (-not $env:ChocolateyInstall) {
#         Set-ExecutionPolicy Bypass -Scope Process -Force;
#         [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
#         Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#         refreshenv
#     }
# }

function Create-Directory {
    param(
        [string]$Path
    )

    if (-not (Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path
    }
}

# Install-Chocolatey

winget install Git.Git --source winget
# choco upgrade git --yes
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

# winget install
# - general tools
winget install DEVCOM.JetBrainsMonoNerdFont --source winget
winget install Microsoft.WindowsApp --source winget
winget install 7zip.7zip --source winget
winget install JGraph.Draw --source winget
winget install Microsoft.PowerShell --source winget
winget install Notepad++.Notepad++ --source winget
winget install Microsoft.Sysinternals.ZoomIt --source winget
winget install JanDeDobbeleer.OhMyPosh --source winget

# choco upgrade 7zip --yes
# choco upgrade drawio --yes
# choco upgrade greenshot --yes
# choco upgrade notepadplusplus --yes
# choco upgrade powershell-core --yes
# choco upgrade zoomit --yes
# choco upgrade oh-my-posh --yes

$windowsBuild = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "ReleaseId").ReleaseId

# - wsl2 (reboot required)
Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
winget install Microsoft.WSL --source winget
# choco upgrade wsl2 --yes

# - install / configure Windows Terminal
winget ianstall Microsoft.WindowsTerminal
# choco upgrade microsoft-windows-terminal --yes

$destination = "$($env:LOCALAPPDATA)/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
if ($UseLocalConfig) {
    Copy-Item -Path "$PSScriptRoot/../config/terminalSettings.json" -Destination "$destination/settings.json"
    Copy-Item -Path "$PSScriptRoot/../config/terminalState.json" -Destination "$destination/state.json"
}
else {
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/terminalSettings.json' -OutFile "$destination/settings.json"
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/terminalState.json' -OutFile "$destination/state.json"
}

# - dev tools
winget install Microsoft.AzureCLI --source winget
winget install Hashicorp.Terraform --source winget
winget install Microsoft.VisualStudioCode --source winget

# choco upgrade azure-cli --yes
# choco upgrade azure-data-studio --yes
# choco upgrade azure-functions-core-tools --yes
# choco upgrade azurestorageexplorer --yes
# choco upgrade docker-desktop --yes
# choco upgrade dotnetcore-sdk --yes
# choco upgrade nuget.commandline --yes
# choco upgrade postman --yes
# choco upgrade terraform --yes
# choco upgrade vscode --yes


# install vscode extensions
refreshenv
code --install-extension hashicorp.terraform
code --install-extension ms-vscode.powershell
code --install-extension eamodio.gitlens
code --install-extension github.github-vscode-theme
# code --install-extension ms-dotnettools.csharp
# code --install-extension msazurermtools.azurerm-vscode-tools
# code --install-extension ms-azure-devops.azure-pipelines
# code --install-extension ms-dotnettools.csharp
# code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension redhat.vscode-yaml
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension mcsodbrenner.better-open-editors
code --install-extension github.copilot-chat
