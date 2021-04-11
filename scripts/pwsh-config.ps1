function Install-PowerShellModule {
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $ModuleName,

        [ScriptBlock]
        [Parameter(Mandatory = $true)]
        $PostInstall = {}
    )

    if (!(Get-Command -Name $ModuleName -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $ModuleName"
        Install-Module -Name $ModuleName -Scope CurrentUser -Confirm $true
        Import-Module $ModuleName -Confirm

        Invoke-Command -ScriptBlock $PostInstall
    } else {
        Write-Host "$ModuleName was already installed, skipping"
    }
}

Install-PowerShellModule 'Posh-Git' { Add-PoshGitToProfile -AllHosts }
Install-PowerShellModule 'oh-my-posh' { }
Install-PowerShellModule 'PSReadLine' { }
Install-PowerShellModule 'Az.Tools.Predictor' { }

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/Microsoft.PowerShell_profile.ps1' -OutFile $PROFILE
