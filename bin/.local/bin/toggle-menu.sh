#!/bin/sh
if pgrep -x vicinae; then
  killall vicinae
else
  vicinae open
fi
