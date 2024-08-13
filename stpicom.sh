#!/bin/bash

# Create the Picom startup script
mkdir -p ~/.config/i3/scripts
cat > ~/.config/i3/scripts/start_picom.sh << 'EOF'
#!/bin/bash
# Start Picom with default configuration
picom --config ~/.config/picom/picom.conf &
EOF

# Make the startup script executable
chmod +x ~/.config/i3/scripts/start_picom.sh

# Add the script to the i3 configuration to run on startup
if ! grep -q 'start_picom.sh' ~/.config/i3/config; then
    echo 'exec --no-startup-id ~/.config/i3/scripts/start_picom.sh' >> ~/.config/i3/config
fi

echo "Picom has been configured to start with i3. Please reload your i3 configuration or restart i3."
