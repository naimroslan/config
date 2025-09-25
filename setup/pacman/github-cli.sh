#!/bin/bash
set -e

sudo pacman -S --noconfirm github-cli

# Basic Git configuration
git config --global user.email "adrian@rooftop.my"
git config --global user.name "Adrian-LSY"

# SSH signing configuration (for verified commits)
git config --global gpg.format ssh
git config --global user.signingkey "/home/adrian/.ssh/adrian_rooftop_ed25519.pub"
git config --global commit.gpgsign true

# Set up SSH allowed signers file (if it doesn't exist)
mkdir -p ~/.config/git
if [ ! -f ~/.config/git/allowed_signers ]; then
    echo "adrian@rooftop.my $(cat ~/.ssh/adrian_rooftop_ed25519.pub)" > ~/.config/git/allowed_signers
fi
git config --global gpg.ssh.allowedsignersfile ~/.config/git/allowed_signers
