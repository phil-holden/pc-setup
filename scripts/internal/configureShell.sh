#!/bin/bash

set -euo pipefail

cd ~

if [[ ! -d ".oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.zshrc --silent >  .zshrc

if [[ ! -f ".oh-my-zsh/custom/themes/agnoster.zsh-theme" ]]; then
    curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/agnoster.zsh-theme --silent > .oh-my-zsh/custom/themes/agnoster.zsh-theme
fi

if [[ ! -f ".oh-my-zsh/custom/alias.zsh" ]]; then
    curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/alias.zsh --silent > .oh-my-zsh/custom/alias.zsh
fi