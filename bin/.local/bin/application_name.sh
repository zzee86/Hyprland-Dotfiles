#!/bin/bash

FILE="$1"

APP_CLASS=$(hyprctl activewindow -j | awk -F'"' '/"class"/ {print $(NF-1)}')

APP_TITLE=$(hyprctl activewindow -j | awk -F'"' '/"title"/ {print $(NF-1)}')

if [ -z "$APP_CLASS" ] || [[ "$APP_CLASS" == steam_app* ]]; then
    APP="$APP_TITLE"
else
    APP="$APP_CLASS"
fi

APP=$(echo "$APP" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/[[:space:]]/_/g' | tr -cd '[:alnum:]_-')

DIR=$(dirname "$FILE")
DATE=$(date +%F_%H-%M-%S)

APP_DIR="$DIR/$APP"
mkdir -p "$DIR/$APP"

NEW_FILE="$APP_DIR/${APP}_${DATE}.mp4"

mv "$FILE" "$NEW_FILE"
#notify-send "Replay Saved" "Saved as $NEW_FILE"
