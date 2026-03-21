#!/bin/bash
if pgrep -x "waybar" > /dev/null || pgrep -x "swaync" > /dev/null
then
    killall -9 waybar
    killall -9 swaync
    sleep 0.1  # Add a short delay to make sure it has been killed
fi
waybar &
swaync &