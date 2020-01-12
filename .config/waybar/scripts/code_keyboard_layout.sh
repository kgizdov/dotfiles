#!/bin/zsh
# Script to get keyboard active layout in Sway
# for WASD Code Keyboar over USB
layout_name=$(swaymsg -t get_inputs | jq '.[] | select(.identifier=="1241:361:USB_Keyboard") | .xkb_active_layout_name')
# echo "${layout_name}"
if [ "${layout_name}" = '"Bulgarian (new phonetic)"' ]; then
  echo '{"text": "bg", "tooltip": "", "class": "", "percentage": 0}' | jq --unbuffered --compact-output
elif [ "${layout_name}" = '"English (US)"' ]; then
  echo '{"text": "us", "tooltip": "", "class": "", "percentage": 0}' | jq --unbuffered --compact-output
else
  echo '{"text": "--", "tooltip": "", "class": "", "percentage": 0}' | jq --unbuffered --compact-output
fi
