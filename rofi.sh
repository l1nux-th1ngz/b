#!/bin/bash

# Install Rofi
sudo apt-get update
sudo apt-get -y install rofi

# Create the Rofi configuration directory if it doesn't exist
mkdir -p ~/.config/rofi

# Copy the Rofi configuration file if it exists
if [ -f /etc/rofi/rofi.conf ]; then
    cp /etc/rofi/rofi.conf ~/.config/rofi/config
else
    echo "/etc/rofi/rofi.conf not found, please check your Rofi installation."
    exit 1
fi

echo "Rofi configuration setup complete!"
