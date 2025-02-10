#!/bin/bash

sudo apt-get -y install xorg xbacklight xbindkeys xvkbd xinput network-manager network-manager-gnome 
sudo apt-get -y install dosfstools avahi-daemon acpi acpid gvfs gvfs-backends pamixer dosfstools avahi-daemon
sudo apt-get -y install acpi acpid nala geany cmake meson ninja-build wget curl suckless-tools
sudo apt-get -y install feh fonts-recommended fonts-font-awesome fonts-terminus ttf-mscorefonts-installer 
sudo apt-get -y install papirus-icon-theme exa flameshot qimgv rofi dunst libnotify-bin xdotool unzip 
sudo apt-get -y install libnotify-dev firefox-esr xdg-user-dirs-gtk rxvt-unicode bluez blueman

echo "Enabling services..."
sudo systemctl enable avahi-daemon || echo "Warning: Failed to enable avahi-daemon."
sleep 3
sudo systemctl enable acpid || echo "Warning: Failed to enable acpid."
sleep 3
sudo systemctl enable bluetooth || echo "Warning: Failed to enable bluetooth."
sleep 3
xdg-user-dirs-update
sleep 3
xdg-user-dirs-gtk-update
sleep 3
sudo apt-get -y install bspwm polybar sxhkd alacritty brightnessctl dunst rofi jq 
sudo apt-get -y install policykit-1-gnome git playerctl mpd ncmpcpp geany ranger 
sudo apt-get -y install mpc picom xdotool feh ueberzug maim pamixer libwebp-dev
sudo apt-get -y install xdg-user-dirs nala webp-pixbuf-loader zsh zsh-autosuggestions 
sudo apt-get -y install zsh-syntax-highlighting nemo zip unzip kitty terminator
sudo apt-get -y install gvfs gvfs-backends engrampa tint2 dmenu xdo jgmenu redshift xautolock 
sudo apt-get -y install fzf ytfzf yt-dlp gawk tumbler gpick neofetch xdg-utils 
sudo apt-get -y install python-is-python3 python3-gi gir1.2-nm-1.0 duf libglib2.0-bin btop
sudo apt-get -y install ncdu bat exa wmctrl acpid xclip scrot acpi mpdris2 jq
sudo apt-get -y install libplayerctl-dev gir1.2-playerctl-2.0 lxappearance bc
sudo apt-get -y install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev 
sudo apt-get -y install libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev 
sudo apt-get -y install libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev 
sudo apt-get -y install libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev 
sudo apt-get -y install libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev 
sudo apt-get -y install libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev 
sudo apt-get -y install libxcb-xfixes0-dev libxext-dev uthash-dev libgtk-4-dev libadwaita-1-dev 

sudo apt-get -y install sddm --no-install-recommends

git clone https://github.com/hidayry/dotfiles-bspwm.git || { echo "Failed to clone dotfiles-bspwm repository."; exit 1; }

cd dotfiles-bspwm
# Make usable for everybody not just username
find . -type f -exec sed -i "s/ryan/$(whoami)/g" {} +

# Copy
cp -r config/* ~/.config/
cp -r local/* ~/.local/
cp -r home/* ~/

echo "-- change this line =
eww -c \"$HOME\"/.config/bspwm/$(whoami)/src/eww daemon &
polybar -q $(whoami)-bar -c \"$HOME\"/.config/bspwm/$(whoami)/config.ini &
#eww -c \"$HOME\"/.config/bspwm/$(whoami)/src/eww open bar &

-- become =
#eww -c \"$HOME\"/.config/bspwm/$(whoami)/src/eww daemon &
#polybar -q $(whoami)-bar -c \"$HOME\"/.config/bspwm/$(whoami)/config.ini &
eww -c \"$HOME\"/.config/bspwm/$(whoami)/src/eww open bar &

-- in =
~/.config/bspwm/bspwmrc"

curl https://raw.githubusercontent.com/phenax/bsp-layout/master/install.sh | bash - || { echo "Failed to install bsp-layout."; exit 1; }
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip || { echo "Failed to download greenclip."; exit 1; }
sudo mv greenclip /usr/bin/ || { echo "Failed to move greenclip."; exit 1; }
sudo chmod +x /usr/bin/greenclip || { echo "Failed to make greenclip executable."; exit 1; }

git clone https://github.com/noctuid/tdrop.git || { echo "Failed to clone tdrop repository."; exit 1; }
cd tdrop
sudo make install || { echo "Failed to install tdrop."; exit 1; }
cd ..

git clone https://github.com/baskerville/xqp.git || { echo "Failed to clone xqp repository."; exit 1; }
cd xqp
sudo make install || { echo "Failed to install xqp."; exit 1; }

git clone https://github.com/FT-Labs/picom "$INSTALL_DIR/picom" || { echo "Failed to clone Picom repository."; exit 1; }
cd "$INSTALL_DIR/picom" || { echo "Failed to access Picom directory."; exit 1; }
meson setup --buildtype=release build || { echo "Meson setup failed."; exit 1; }
ninja -C build || { echo "Ninja build failed."; exit 1; }
sudo ninja -C build install || { echo "Ninja install failed."; exit 1; }
echo "Picom installation complete."
