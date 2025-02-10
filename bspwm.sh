#!/bin/bash

# Main list of packages
packages=(
    "bspwm"
    "sxhkd"
    "polybar"
    "suckless-tools"
    "rxvt-unicode"
    "firefox-esr"
    "xorg"
    "xserver-xorg"
    "xbacklight"
    "xbindkeys"
    "xvkbd"
    "xinput"
    "build-essential"
    "git"
    "curl"
    "wget"
    "policykit-1-gnome"
    "network-manager"
    "network-manager-gnome"
    "pamixer"
    "nemo"
    "nemo-archive-plugin"
    "zip"
    "dex"
    "unzip"
    "file-roller"
    "lxappearance"
    "dialog"
    "mtools"
    "dosfstools"
    "avahi-daemon"
    "acpi"
    "acpid"
    "gvfs"
    "gvfs-backends"
    "gnome-power-manager"
    "pulseaudio"
    "pavucontrol"
    "pulsemixer"
    "feh"
    "fonts-recommended"
    "fonts-font-awesome"
    "fonts-terminus"
    "papirus-icon-theme"
    "exa"
    "maim"
    "rofi"
    "scrot"
    "slop"
    "dunst"
    "npm"
    "libnotify-bin"
    "xdotool"
    "libnotify-dev"
    "nnn"
    "geany"
    "geany-plugin-addons"
    "geany-plugin-git-changebar"
    "geany-plugin-spellcheck"
    "geany-plugin-treebrowser"
    "geany-plugin-markdown"
    "geany-plugin-insertnum"
    "geany-plugin-lineoperations"
    "geany-plugin-automark"
    "redshift"
    "xdg-user-dirs-gtk"
)

# Function to install packages if they are not already installed
install_packages() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed
    for pkg in "${pkgs[@]}"; do
        if ! dpkg -l | grep -q " $pkg "; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        sudo apt-get update
        sudo apt-get -y install "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}

# Call function to install packages
install_packages "${packages[@]}"

xdg-user-dirs-gtk-update

mkdir -p ~/.config/{bspwm,sxhkd,dunst}

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
