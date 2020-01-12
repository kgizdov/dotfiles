#!/bin/zsh
# Script to get keyboard active layout in Sway
# for built-in Dell XPS keyboard
layout_name=$(swaymsg -t get_inputs | jq '.[] | select(.identifier=="1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name')
# echo "${layout_name}"
# 3 return options encode 3 intervals from 0% to 100%
# namely 0-32, 33-66, 67-100
# this value is used for selecting an icon to display
if [ "${layout_name}" = '"Bulgarian (new phonetic)"' ]; then
  echo '{"text":"bg", "tooltip": "", "class": "", "percentage": 0}' | jq --unbuffered --compact-output
elif [ "${layout_name}" = '"English (UK)"' ]; then
  echo '{"text":"uk", "tooltip": "", "class": "", "percentage": 50}' | jq --unbuffered --compact-output
else
  echo '{"text":"--", "tooltip": "", "class": "", "percentage": 100}' | jq --unbuffered --compact-output
fi
