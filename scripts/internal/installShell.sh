#!/bin/bash

set -euo pipefail

sudo apt-get install zsh -y

chsh -s $(which zsh)
