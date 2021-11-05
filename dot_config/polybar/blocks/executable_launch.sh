#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="/home/daddyingrave/.config/polybar/blocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
if type "xrandr"; then
  xrandr --query | grep " connected" | cut -d" " -f 1-3 | while read m; do
     if [[ $m == *"primary"* ]]; then
       export TRAY_POSITION="right"
     else 
       export TRAY_POSITION=""
     fi
     export MONITOR=$(echo $m | cut -d " " -f1)
     echo $MONITOR
     echo $TRAY_POSITION
     polybar --reload main -c "$DIR"/config.ini &
  done
else
  polybar --reload main -c "$DIR"/config.ini &
fi
