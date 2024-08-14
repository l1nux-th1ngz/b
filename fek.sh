#!/usr/bin/env bash

# Update and upgrade the system
sudo apt update
sudo apt full-upgrade -y
sudo apt clean
sudo apt autoremove -y
sudo apt autoclean

# Install required packages
sudo apt install -y build-essential \
  cmake cmake-data pkg-config libcairo2-dev \
  libxcb1-dev libxcb-util-dev libxcb-randr-dev \
  libxcb-composite-dev python3-xcbgen xcb-proto \
  libxcb-image-dev libxcb-ewmh-dev meson ninja-build \
  libxcb-icccm4-dev geany geany-plugins nemo yad zenity \
  libcurl4-openssl-dev libjsoncpp-dev libpulse-dev libmpdclient-dev libasound2-dev libxcb-cursor-dev libxcb-xrm-dev libxcb-xkb-dev libnl-genl-3-dev \
  bspwm sxhkd subversion nemo ranger xdg-user-dirs xdg-user-dirs-gtk rofi feh numlockx \
  dunst neofetch imagemagick webp unifont curl wget playerctl brightnessctl

# Update user directories
xdg-user-dirs-update 
xdg-user-dirs-gtk-update

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

# Build Polybar
cd /tmp
git clone --recursive https://github.com/polybar/polybar
cd polybar/
sed -i 's/read /#read /g' build.sh
sudo ./build.sh

# Install fonts via SVN
[ ! -d "$HOME/.local/share/fonts" ] && mkdir -p "$HOME/.local/share/fonts"
svn export https://github.com/terroo/fonts/trunk/fonts
mv fonts "$HOME/.local/share/fonts/"
fc-cache -fv

# Configure all installed packages
cd $CURRENT_DIR
mv bspwm/ $HOME/.config/
mv sxhkd/ $HOME/.config/
mv dunst/ $HOME/.config/
mv polybar/ $HOME/.config/
mv rofi/ $HOME/.config/
mv wallpaper.jpg $HOME/.wallpaper.jpg
feh --bg-scale $HOME/.wallpaper.jpg

# Detect network interface
NETW=$(ip addr | awk '/state UP/ {print $2}' | sed 's/://g')
sed -i -r "s/a-z-9+ ;redoo/$NETW/g" $HOME/.config/polybar/modules.ini

# Detect distribution and update Polybar config
if grep -i 'debian' /etc/issue; then
  _d=" Debian"
elif grep -i 'ubuntu' /etc/issue; then
  _d=" Ubuntu"
elif grep -i 'mint' /etc/issue; then
  _d=" Linux Mint"
fi

sed -i "s/DISTROOO/$_d/" $HOME/.config/polybar/user_modules.ini
# Uncomment the relevant section in the Polybar menu script
# sed -i "/$_d/s/^#//" $HOME/.config/polybar/scripts/menu

git clone https://github.com/drewgrif/bookworm-scripts.git
