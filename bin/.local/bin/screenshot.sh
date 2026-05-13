#!/bin/bash

LOCKFILE="/tmp/local_screenshot.lock"

if [ -e "$LOCKFILE" ]; then
  exit 0
fi

trap 'rm -f "$LOCKFILE"' EXIT

touch "$LOCKFILE"

geometry="$(slurp)" || exit 0
file="$HOME/Pictures/Screenshots/$(date +%s).png"

grim -g "$geometry" - | tee "$file" | wl-copy

notify-send "Screenshot Saved & Copied" "$file" -i "$file"
