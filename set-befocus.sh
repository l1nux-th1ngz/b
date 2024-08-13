#!/bin/bash
mkdir -p ~/.config/bspwm/scripts
mv bfocus.sh ~/.config/bspwm/scripts/
chmod +x ~/.config/bspwm/scripts/bfocus.sh


# Add to sxhkdrc
super + shift + x
    ~/.config/bspwm/scripts/bfocus.sh process_name executable_name --take-first
