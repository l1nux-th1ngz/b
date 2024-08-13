
#!/bin/bash

# Update package lists
sudo apt update

# Install required packages for i3 and development
sudo apt install -y meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb1-dev libxcb-icccm4-dev \
libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev \
i3status cmake cmake-extras build-essential autoconf automake qt5ct

# Install Xorg and related tools
sudo apt install -y xorg xbacklight xbindkeys xvkbd xinput xorg-dev ninja-build

# Install Python and pip
sudo apt install -y python3 python3-pip

# Install microcode for Intel processors
sudo apt install -y intel-microcode

# Install i3, file managers, and related tools
sudo apt install -y i3 i3wm nemo ranger xdg-user-dirs xdg-user-dirs-gtk i3-wm dunst i3lock i3status suckless-tools \
network-manager-gnome hsetroot rxvt-unicode xsel lxappearance scrot cmus vim zenity yad nala xdotool dex cava \
libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev \
libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev \
libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
# Install appearance management tools
sudo apt install -y lxappearance rofi dunst polybar dconf-editor

# Create and update user directories
xdg-user-dirs-update
xdg-user-dirs-gtk-update

# Install network and system event tools
sudo apt install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends gvfs udisks2 udiskie

# Enable services
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

# Install terminal emulators
sudo apt install -y kitty alacritty clipnotify

# Install sound packages
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa

# Install Neofetch and htop
sudo apt install -y neofetch htop fzf dmenu xsel

# Install EXA
sudo apt install -y exa

# Install Bluetooth packages
sudo apt install -y bluez blueman
sudo systemctl enable bluetooth

# Install additional tools
sudo apt install -y feh dmenu numlockx libnotify-bin unzip geany geany-plugins zip lolcat

# Install text editors
sudo apt install -y neovim

# Install fonts
sudo apt install -y fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus fonts-cascadia-code

# Clone and set up i3 starter pack
git clone https://github.com/addy-dclxvi/i3-starterpack.git && cp -a i3-starterpack/. ~
# Note: If you don't have git installed, download as zip and extract manually

# Copy the configurations to home directory
cp -a i3-starterpack/. ~
fc-cache -fv  # Refresh font cache

# Setup XSessions for i3
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > /usr/share/xsessions/i3.desktop << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=i3
Comment=Dynamic window manager
Exec=i3
Icon=i3
Type=XSession
EOF

# Clean up
sudo apt autoremove -y
