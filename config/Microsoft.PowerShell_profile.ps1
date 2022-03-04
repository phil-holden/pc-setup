Import-Module -Name posh-git
Import-Module -Name oh-my-posh
Set-PoshPrompt -Theme ~/.poshthemes/.agnostercustom.omp.json

Import-Module -Name Az.Tools.Predictor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

function Run-Terraform { 
    & terraform $args 
}
New-Alias -Name tf -Value Run-Terraform -Force -Option AllScope

function Get-MyIp { 
    Write-Host "Local IP : " ([System.Net.DNS]::GetHostAddresses($env:ComputerName) | Where-Object { $_.AddressFamily -eq "InterNetwork" }).IPAddressToString
    Write-Host "Public IP: " (Invoke-WebRequest "https://icanhazip.com").Content
}
New-Alias -Name myip -Value Get-MyIp -Force -Option AllScope

function Open-ExplorerHere { 
    & explorer .
}
New-Alias -Name ex -Value Open-ExplorerHere -Force -Option AllScope

function Invoke-GitPull {
    & git pull
}
New-Alias -Name gp -Value Invoke-GitPull -Force -Option AllScope
