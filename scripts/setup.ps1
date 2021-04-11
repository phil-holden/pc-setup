Set-ExecutionPolicy Bypass -Scope Process -Force; 

function Install-Chocolatey {
    if (-Not $env:ChocolateyInstall) {
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

function Install-FromChocolatey {
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $PackageName
    )

    choco install $PackageName --yes
}

Install-Chocolatey

Install-FromChocolatey 'git'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.gitconfig' -OutFile (Join-Path $env:USERPROFILE '.gitconfig')


# install choco packages
# - general tools
Install-FromChocolatey '7zip'
Install-FromChocolatey 'greenshot'
Install-FromChocolatey 'notepadplusplus'
Install-FromChocolatey 'zoomit'
Install-FromChocolatey 'powershell-core'

# - dev tools
Install-FromChocolatey 'azure-cli'
Install-FromChocolatey 'azure-data-studio'
Install-FromChocolatey 'docker-desktop'
Install-FromChocolatey 'nuget.commandline'
Install-FromChocolatey 'terraform'
Install-FromChocolatey 'vscode'
