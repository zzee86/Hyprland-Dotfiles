#!/bin/bash

ICON_DIR="$HOME/.config/hypr/Icons"

# Get current volume
get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | tr ' ' '\n' | grep -m1 '%' | tr -d '%'
}

# Get the icon based on action
get_icon() {
    local action="$1"
    local vol
    vol=$(get_volume)

    case "$action" in
        up)
            echo "$ICON_DIR/volume-up.png"
            ;;
        down)
            if [[ "$vol" -eq 0 ]]; then
                echo "$ICON_DIR/mute.png"
            else
                echo "$ICON_DIR/volume-down.png"
            fi
            ;;
        *)
    esac
}

# Show notification
notify_user() {
    local vol="$1"
    local action="$2"
    notify-send -a "Volume-Slider" \
                -h string:x-canonical-private-synchronous:sys-notify \
                -u low \
                -i "$(get_icon "$action")" \
                "Volume: ${vol}%"
}

action="$1"
volume=$(get_volume)

notify_user "$volume" "$action"
