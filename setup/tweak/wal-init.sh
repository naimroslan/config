#!/bin/bash
set -e

# Generate initial wal cache from default wallpaper
WALL="$HOME/.config/hypr/wallpaper/Brisbane_cityscape_6000x4000.jpeg"
if [ -f "$WALL" ]; then
    wal -i "$WALL" -n -q
    echo "Generated initial pywal theme"
fi
