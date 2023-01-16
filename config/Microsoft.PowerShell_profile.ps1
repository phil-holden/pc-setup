oh-my-posh --init --shell pwsh --config ~/.poshthemes/.agnostercustom.omp.json | Invoke-Expression

Import-Module -Name posh-git

Import-Module -Name Az.Tools.Predictor
Set-PSReadLineOption -PredictionViewStyle ListView

function Get-MyIp {
    Write-Host "Local IP : " ([System.Net.DNS]::GetHostAddresses($env:ComputerName) | Where-Object { $_.AddressFamily -eq "InterNetwork" }).IPAddressToString
    Write-Host "Public IP: " (Invoke-WebRequest "https://icanhazip.com").Content
}
New-Alias -Name myip -Value Get-MyIp -Force -Option AllScope

function Open-ExplorerHere {
    & explorer .
}
New-Alias -Name ex -Value Open-ExplorerHere -Force -Option AllScope

function Invoke-Terraform {
    & terraform $args
}
New-Alias -Name tf -Value Invoke-Terraform -Force -Option AllScope

function Invoke-Git {
    & git $args
}
New-Alias -Name g -Value Invoke-Git -Force -Option AllScope

function Invoke-GitPull {
    & git pull
}
New-Alias -Name gp -Value Invoke-GitPull -Force -Option AllScope

function Invoke-Podman {
    & podman $args
}
New-Alias -Name docker -Value Invoke-Podman -Force -Option AllScope
New-Alias -Name p -Value Invoke-Podman -Force -Option AllScope

function Invoke-PodmanContainer {
    & podman container $args
}
New-Alias -Name pc -Value Invoke-PodmanContainer -Force -Option AllScope

function Invoke-PodmanImage {
    & podman image $args
}
New-Alias -Name pi -Value Invoke-PodmanImage -Force -Option AllScope

function Get-AdoBasicAuthHeader {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Token
    )

    $Token = ":$Token"

    $tokenBytes = [System.Text.Encoding]::ASCII.GetBytes($Token)
    $tokenBase64 = [System.Convert]::ToBase64String($tokenBytes)

    return @{ Authorization = "Basic $tokenBase64" }
}
New-Alias -Name adobasicauth -Value Get-AdoBasicAuthHeader -Force -Option AllScope
