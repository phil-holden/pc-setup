# install powershell modules
Write-Host "Installing Module: Az"
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber

Write-Host "Installing Module: oh-my-posh"
Install-Module -Name oh-my-posh -Scope CurrentUser -Repository PSGallery -Force -AllowPrerelease

Write-Host "Installing Module: PowerShellGet"
Install-Module -Name PowerShellGet -Scope CurrentUser -Repository PSGallery -Force

Write-Host "Installing Module: PSReadline"
Install-Module -Name PSReadline -Scope CurrentUser -Repository PSGallery -Force -AllowPrerelease

Write-Host "Installing Module: Az.Tools.Predictor"
Install-Module -Name Az.Tools.Predictor -Scope CurrentUser -Repository PSGallery -Force -AllowPrerelease

# configure powershell profile
if ($null -eq (Test-Path -Path $profile)) {
    New-Item -Path $profile -ItemType file -Force
}

$myProfile = @(Get-Content -Path $profile)

# - oh-my-posh prompt
$promptConfigured = ($myProfile | ForEach-Object { $_ -Match "Set-PoshPrompt" })

if ($null -eq $promptConfigured) {
    Write-Host "Configuring Profile: Posh Prompt"
    Set-Content -Path $profile -Value "`nSet-PoshPrompt -Theme Star"
}

# - az predictor
$predictorConfigured = ($myProfile | ForEach-Object { $_ -Match "Az.Tools.Predictor" })

if ($null -eq $predictorConfigured) {
    Write-Host "Configuring Profile: Predictor"
    Set-Content -Path $profile -Value "`nImport-Module Az.Tools.Predictor"
    Set-Content -Path $profile -Value "`nSet-PSReadLineOption -PredictionSource HistoryAndPlugin"
    Set-Content -Path $profile -Value "`nSet-PSReadLineOption -PredictionViewStyle ListView"
}

# - reload profile
. $profile
