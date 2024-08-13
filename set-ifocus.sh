# Create the i3 scripts directory
mkdir -p ~/.config/i3/scripts

# Move the script to the i3 scripts directory
mv ifocus.sh ~/.config/i3/scripts/

# Make the script executable
chmod +x ~/.config/i3/scripts/ifocus.sh

# Add the keybinding to i3 config
echo 'bindsym $mod+Shift+X exec --no-startup-id ~/.config/i3/scripts/ifocus.sh process_name executable_name --take-first' >> ~/.config/i3/config
