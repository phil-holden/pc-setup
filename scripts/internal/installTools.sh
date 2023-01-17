#!/bin/bash

set -euo pipefail

cd ~

# az cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# tfenv
sudo apt-get install unzip -y
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc

tfenv install 1.3.6
tfenv use 1.3.6