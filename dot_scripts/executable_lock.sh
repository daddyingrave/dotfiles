#!/bin/bash

TMPBG=/tmp/screen.png
LOCK=$HOME/.local/share/icons/lock.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')

# Create blurred screenshot
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=12:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 2 $TMPBG -loglevel quiet

# Remember current player state
WAS_PLAYED=false
if [[ $(playerctl status) == "Playing" ]]; then
  WAS_PLAYED=true
fi

# If something is playing right now - stop it 
if [[ "$WAS_PLAYED" == true ]]; then
  playerctl pause 
fi

# Disable notifications while locked
pkill -u "$USER" -USR1 dunst

i3lock --image=$TMPBG \
  --pointer=default \
  --ignore-empty-password \
  --show-failed-attempts \
  --nofork 

# Enable notifications
pkill -u "$USER" -USR2 dunst

# Party up!
if [[ "$WAS_PLAYED" == true ]]; then
  playerctl play 
fi

rm $TMPBG

