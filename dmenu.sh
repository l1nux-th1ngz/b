#!/bin/bash

# Install dmenu
sudo apt-get -y install dmenu

# Create the dmenu configuration directory
mkdir -p ~/.config/dmenu

# Copy the default or provided dmenu configuration file
# Replace /path/to/your/dmenu_config_file with the actual path
# Uncomment the line below if you have a specific config file to copy
# cp /path/to/your/dmenu_config_file ~/.config/dmenu/dmenu_config

# Add keybinding to i3 config for dmenu
I3_CONFIG="$HOME/.config/i3/config"

# Check if the i3 config file exists
if [ -f "$I3_CONFIG" ]; then
    # Add or update the keybinding for dmenu
    if ! grep -q "dmenu_run" "$I3_CONFIG"; then
        echo "Adding dmenu keybinding to i3 config..."
        echo 'bindsym $mod+d exec --no-startup-id dmenu_run' >> "$I3_CONFIG"
    else
        echo "Keybinding for dmenu already exists in i3 config."
    fi
else
    echo "i3 config file not found at $I3_CONFIG. Please check the path."
fi

echo "Setup complete! Please reload i3 configuration to apply changes."
