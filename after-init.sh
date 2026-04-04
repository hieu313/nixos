#!/bin/bash
set -e

# This script is run after the system is installed and configured

# Yazi
ya pkg install

# Bat
command bat cache --build

# Atuin
echo "go to arch dotfiles, view extend-application.md, and follow the instructions to install atuin"