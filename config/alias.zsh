# terraform
alias tf="terraform"
alias tfi="terraform init"
alias tfv="terraform validate"
alias tfp="terraform plan"
alias tfa="terraform apply"

# git
alias g="git"
alias gc="git clone"
alias gp="git pull"
alias gpl="git pull"
alias gpu="git push"

# util
alias cls="clear"

# bedrock
function brs() {
    export STORAGE_ACCOUNT="$1"
    export ARM_ACCESS_KEY=`az storage account keys list -n $STORAGE_ACCOUNT | jq '.[0] | .value'`
}