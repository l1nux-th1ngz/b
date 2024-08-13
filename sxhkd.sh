#!/bin/bash

# Install sxhkd
sudo apt-get update
sudo apt-get -y install sxhkd

# Create the sxhkd configuration directory
mkdir -p ~/.config/sxhkd

# Copy the example sxhkdrc file to the user's configuration directory
cp /usr/share/doc/sxhkd/examples/sxhkdrc ~/.config/sxhkd/

# Make the sxhkdrc file executable
chmod +x ~/.config/sxhkd/sxhkdrc

echo "sxhkd setup complete!"
