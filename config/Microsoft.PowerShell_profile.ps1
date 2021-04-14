Import-Module -Name posh-git
Import-Module -Name oh-my-posh
Set-Theme Pure

Import-Module -Name Az.Tools.Predictor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

function Run-Terraform { & terraform $args }
New-Alias -Name tf -Value Run-Terraform -Force -Option AllScope
