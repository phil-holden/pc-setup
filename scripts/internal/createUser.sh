#!/bin/bash

set -euo pipefail

USERNAME=$1

# add the user if they don't exist
if [[ $(cat /etc/passwd | grep ${USERNAME} | wc -l) == 0 ]]; then
    useradd -m -s /bin/bash ${USERNAME}
fi

# add to sudo group
usermod -aG sudo ${USERNAME}

# ensure no password is set
passwd -d ${USERNAME}

# set wsl default user
sudo echo "[user]" >> /etc/wsl.conf
sudo echo "default=${USERNAME}" >> /etc/wsl.conf
