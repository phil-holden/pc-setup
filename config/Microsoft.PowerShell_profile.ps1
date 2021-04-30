Import-Module -Name posh-git
Import-Module -Name oh-my-posh
Set-PoshPrompt -Theme ~/.poshthemes/.agnostercustom.omp.json

Import-Module -Name Az.Tools.Predictor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

function Run-Terraform { & terraform $args }
New-Alias -Name tf -Value Run-Terraform -Force -Option AllScope

function Get-MyIp { $(Invoke-WebRequest "https://icanhazip.com").Content }
New-Alias -Name myip -Value Get-MyIp -Force -Option AllScope
