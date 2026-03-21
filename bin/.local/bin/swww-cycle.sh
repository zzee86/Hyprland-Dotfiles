#!/bin/bash
set -x  # <-- enables command output (debug mode)
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
INTERVAL=600
last=""

CURRENT_WALLPAPER_FILE="$HOME/.config/hypr/CurrentWallpaper.png"

while true; do
    img=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f | shuf -n 1)
    [[ "$img" == "$last" ]] && continue
    swww img "$img" --transition-fps 60 --transition-step 255 --transition-type any

    cp "$img" "$CURRENT_WALLPAPER_FILE"
    
    last="$img"
    sleep "$INTERVAL"
done