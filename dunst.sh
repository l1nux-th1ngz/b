#!/bin/bash

# Install Dunst
sudo apt-get update
sudo apt-get -y install dunst

# Create the Dunst configuration directory if it doesn't exist
mkdir -p ~/.config/dunst

# Copy the Dunst configuration file if it exists
if [ -f /etc/dunst/dunstrc ]; then
    cp /etc/dunst/dunstrc ~/.config/dunst/
else
    echo "/etc/dunst/dunstrc not found, please check your Dunst installation."
    exit 1
fi

echo "Dunst configuration setup complete!"
