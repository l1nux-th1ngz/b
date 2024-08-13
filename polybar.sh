#!/bin/bash

# Install Polybar
sudo apt-get update
sudo apt-get -y install polybar

# Create the Polybar configuration directory if it doesn't exist
mkdir -p ~/.config/polybar

# Check if the Polybar configuration file exists before copying
if [ -f /etc/polybar/config.ini ]; then
    cp /etc/polybar/config.ini ~/.config/polybar/
else
    echo "/etc/polybar/config.ini not found, please check your Polybar installation."
    exit 1
fi
