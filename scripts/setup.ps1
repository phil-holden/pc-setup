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
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.gitconfig' -OutFile (Join-Path $env:USERPROFILE '.gitconfig')

Create-Directory -Path (Join-Path $env:USERPROFILE '.poshthemes')

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.agnostercustom.omp.json' -OutFile (Join-Path $env:USERPROFILE '.poshthemes/.agnostercustom.omp.json')

# install choco packages
# - general tools
choco upgrade 7zip --yes
choco upgrade greenshot --yes
choco upgrade notepadplusplus --yes
choco upgrade zoomit --yes
choco upgrade powershell-core --yes --pre
choco upgrade cascadiacode --yes
choco upgrade cascadiacodepl --yes
choco upgrade cascadia-code-nerd-font --yes

$windowsBuild = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "ReleaseId").ReleaseId

# add pwsh preview to the path
if (-Not ($env:Path -like "*C:\Program Files\PowerShell\7-preview*")) {
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\PowerShell\7-preview", "User")
}

# if we're on a 'decent' Windows build we can run WindowsTerminal and WSL2
if ($windowsBuild -ge 1903) {
    # - wsl2 (reboot required)
    Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
    choco upgrade wsl2 --yes

    # - install / configure Windows Terminal
    choco upgrade gsudo --yes
    choco upgrade microsoft-windows-terminal --yes --pre

    $wtFolder = Get-ChildItem -Directory -Path (Join-Path $env:LocalAppData 'Packages') -Filter "*Microsoft.WindowsTerminalPreview*"
    Remove-Item -Path (Join-Path $env:LocalAppData "Packages/$($wtFolder.Name)/LocalState") -Force -Recurse

    Create-Directory -Path (Join-Path $env:USERPROFILE '.terminal')

    New-Item -ItemType SymbolicLink -Path (Join-Path $env:LocalAppData "Packages/$($wtFolder.Name)/LocalState") -Target (Join-Path $env:USERPROFILE '.terminal')

    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/terminalSettings.json' -OutFile (Join-Path $env:USERPROFILE '.terminal/settings.json')
}
else {
    # on an older Windows build we'll drop back to running 'cmder'
    choco upgrade cmder --yes

    refreshenv

    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/cmderSettings.xml' -OutFile (Join-Path $env:ConEmuDir 'ConEmu.xml')
}

# - dev tools
choco upgrade azure-cli --yes
choco upgrade azure-data-studio --yes
choco upgrade docker-desktop --yes
choco upgrade nuget.commandline --yes
choco upgrade terraform --yes
choco upgrade vscode --yes

# install vscode extensions
refreshenv
code --install-extension hashicorp.terraform
code --install-extension ms-vscode.powershell
code --install-extension eamodio.gitlens
code --install-extension github.github-vscode-theme
code --install-extension ms-dotnettools.csharp
code --install-extension msazurermtools.azurerm-vscode-tools
