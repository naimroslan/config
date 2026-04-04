#!/bin/bash
set -e

sudo pacman -S --noconfirm github-cli

# Basic Git configuration
git config --global user.email "naim@rooftop.my"
git config --global user.name "naim-rooftop"

# SSH signing configuration (for verified commits)
git config --global gpg.format ssh
git config --global user.signingkey "/home/naimroslan/.ssh/id_ed25519.pub"
git config --global commit.gpgsign true

# Set up SSH allowed signers file (idempotent)
mkdir -p ~/.config/git
ALLOWED_SIGNERS_FILE="$HOME/.config/git/allowed_signers"
if [ ! -f "$ALLOWED_SIGNERS_FILE" ] || ! grep -q "naim@rooftop.my" "$ALLOWED_SIGNERS_FILE"; then
    echo "naim@rooftop.my $(cat ~/.ssh/id_ed25519.pub)" >> "$ALLOWED_SIGNERS_FILE"
fi
git config --global gpg.ssh.allowedsignersfile "$ALLOWED_SIGNERS_FILE"
