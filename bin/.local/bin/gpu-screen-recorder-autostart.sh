#!/bin/bash

#LOGFILE="/tmp/gpu-screen-recorder.log"

# redirect all output to log (stdout + stderr)
#exec >> "$LOGFILE" 2>&1

#echo "=============================="
#echo "[$(date)] gpu-screen-recorder starting"

sleep 10

gpu-screen-recorder \
  -w screen \
  -f 60 \
  -r 60 \
  -c mp4 \
  -a 'app-inverse:LibreWolf|app-inverse:WEBRTC VoiceEngine' \
  -a 'app:LibreWolf' \
  -a 'app:WEBRTC VoiceEngine' \
  -a 'easyeffects_source' \
  -o "$HOME/Videos/replays" \
  -sc "$HOME/.local/bin/application_name.sh" &

#echo "[$(date)] gpu-screen-recorder launched (PID $!)"
