#!/bin/bash

set -euo pipefail

sudo apt-get install zsh

chsh -s $(which zsh)
