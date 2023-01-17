#!/bin/bash

set -euo pipefail

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/.zshrc --output .zshrc

curl https://raw.githubusercontent.com/phil-holden/pc-setup/main/config/agnoster.zsh-theme --output ./.oh-my-posh/custom/themese/agnoster.zsh-theme