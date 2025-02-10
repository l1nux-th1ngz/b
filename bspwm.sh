sudo apt-get -y install bspwm polybar sxhkd alacritty brightnessctl dunst rofi jq 
sudo apt-get -y install policykit-1-gnome git playerctl mpd ncmpcpp geany ranger 
sudo apt-get -y install mpc picom xdotool feh ueberzug maim pamixer libwebp-dev
sudo apt-get -y install xdg-user-dirs nala webp-pixbuf-loader zsh zsh-autosuggestions 
sudo apt-get -y install zsh-syntax-highlighting nemo zip unzip kitty terminator
sudo apt-get -y install gvfs gvfs-backends engrampa tint2 dmenu xdo jgmenu redshift xautolock 
sudo apt-get -y install fzf ytfzf yt-dlp gawk tumbler gpick neofetch xdg-utils 
sudo apt-get -y install python-is-python3 python3-gi gir1.2-nm-1.0 duf libglib2.0-bin btop
sudo apt-get -y install ncdu bat exa wmctrl acpid xclip scrot acpi mpdris2 
sudo apt-get -y install libplayerctl-dev gir1.2-playerctl-2.0 lxappearance bc

git clone https://github.com/hidayry/dotfiles-bspwm.git

cd dotfiles-bspwm
# Make usable for everybody not just username ryan
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

curl https://raw.githubusercontent.com/phenax/bsp-layout/master/install.sh | bash -
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
sudo mv greenclip /usr/bin/
sudo chmod +x /usr/bin/greenclip

git clone https://github.com/noctuid/tdrop.git
cd tdrop
sudo make install
cd ..

git clone https://github.com/baskerville/xqp.git
cd xqp
sudo make install
