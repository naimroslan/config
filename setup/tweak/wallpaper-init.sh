#!/bin/bash
set -e

mkdir -p "$HOME/wallpapers"

# Copy default wallpaper if directory is empty
if [ -z "$(ls -A "$HOME/wallpapers" 2>/dev/null | grep -v '^\.')" ]; then
    cp "$HOME/.config/hypr/wallpaper/Brisbane_cityscape_6000x4000.jpeg" "$HOME/wallpapers/"
    ln -sf "$HOME/wallpapers/Brisbane_cityscape_6000x4000.jpeg" "$HOME/wallpapers/current"
    echo "Copied default wallpaper to ~/wallpapers/"
fi
