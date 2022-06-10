[CmdletBinding()]
param (
    [Parameter()]
    [Switch]
    $UseLocalConfig
)

Write-Host "Installing Module: Az"
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber

Write-Host "Installing Module: PoshGit"
Install-Module -Name Posh-Git -Scope CurrentUser -Repository PSGallery -Force
Import-Module -Name Posh-Git

Write-Host "Installing Module: PSReadLine"
Install-Module -Name PSReadLine -Scope CurrentUser -Repository PSGallery -Force -AllowClobber -AllowPreRelease
Import-Module -Name PSReadLine

Write-Host "Installing Module: Az.Tools.Predictor"
Install-Module -Name Az.Tools.Predictor -Scope CurrentUser -Repository PSGallery -Force
Import-Module -Name Az.Tools.Predictor

if ($UseLocalConfig) {
    Copy-Item -Path "$PSScriptRoot/../config/Microsoft.PowerShell_profile.ps1" -Destination $PROFILE
}
else {
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/Microsoft.PowerShell_profile.ps1' -OutFile $PROFILE
}
