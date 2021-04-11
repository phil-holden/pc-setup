Write-Host "Installing Module: Az"
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber

Write-Host "Installing Module: PoshGit"
Install-Module -Name Posh-Git -Scope CurrentUser -Repository PSGallery -Force
Import-Module -Name Posh-Git

Write-Host "Installing Module: oh-my-posh"
Install-Module -Name oh-my-posh -Scope CurrentUser -Repository PSGallery -Force
Import-Module -Name oh-my-posh

Write-Host "Installing Module: PSReadLine"
Install-Module -Name PSReadLine -Scope CurrentUser -Repository PSGallery -Force -AllowClobber -AllowPreRelease
Import-Module -Name PSReadLine

Write-Host "Installing Module: Az.Tools.Predictor"
Install-Module -Name Az.Tools.Predictor -Scope CurrentUser -Repository PSGallery -Force
Import-Module -Name Az.Tools.Predictor

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/Microsoft.PowerShell_profile.ps1' -OutFile $PROFILE
