#!/bin/bash

set -euo pipefail

cd ~

if [[ ! -d ".oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -f ".zshrc" ]]; then
    curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.zshrc --silent >  .zshrc
fi

if [[ ! -f ".oh-my-post/custom/themes/agnoster.zsh-theme" ]]; then
    curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/agnoster.zsh-theme --silent > .oh-my-zsh/custom/themes/agnoster.zsh-theme
fi