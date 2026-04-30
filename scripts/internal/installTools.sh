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

# terraform-docs
curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.22.0/terraform-docs-v0.22.0-linux-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
sudo mv terraform-docs /usr/local/bin/
rm terraform-docs.tar.gz

# git config
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
git config --global credential.https://dev.azure.com.useHttpPath true
