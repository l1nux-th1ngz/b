#!/bin/bash

# Clone the Picom repository
git clone https://github.com/dccsillag/picom.git

# Change to the Picom directory
cd picom || { echo "Failed to enter picom directory"; exit 1; }

# Set up the build directory and configure the build
meson setup --buildtype=release build || { echo "Meson setup failed"; exit 1; }

# Build Picom using ninja
ninja -C build || { echo "Ninja build failed"; exit 1; }

# Install Picom
sudo ninja -C build install || { echo "Ninja install failed"; exit 1; }

# Create Picom configuration directory
mkdir -p ~/.config/picom

# Copy default configuration to user directory
cp /etc/xdg/picom.conf ~/.config/picom/picom.conf || { echo "Failed to copy picom configuration"; exit 1; }

echo "Picom installation and configuration complete!"
