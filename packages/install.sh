#! /bin/bash

su root

# Timezone set
timedatectl set-timezone Europe/London

# Update
pacman -Syu

# pacman config
cp ./confs/pacman.conf /etc/pacman.conf

pacman -S --needed reflector
echo "Making a backup of the mirror list"
cp /etc/pacman.d/mirrorlist 
echo "Completed"

# Reflector
pacman -S --needed reflector
echo "Making a backup of the mirror list"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Completed"

reflector --country 'GB' --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Superuser support
pacman -S --needed sudo

# Security
pacman -S --needed ufw
ufw enable
systemctl enable ufw.service

# Package Cleaning
pacman -S pacman-contrib
systemctl enable paccache.timer

# Base Development tools
pacman -S --needed base-devel git wget

# Video Drivers
pacman -S --needed intel-media-driver

# Audio Drivers
pacman -S --needed pipewire wireplumber pipewire-pulse pipewire-alsa

# DE
pacman -S --needed plasma-desktop plasma-nm plasma-pa kscreen

# Display Manager
pacman -S --needed sddm
systemctl enable sddm.service

# CLI/TUI applications
pacman -S --needed kitty nano fastfetch btop powertop  spotifyd cmatrix

#  Fonts
pacman -S --needed noto-fonts-* ttf-hack  powerline-fonts

#  Applications
pacman -S --needed firefox thunderbird code p7zip nano dolphin spectacle discord

# Install AUR helper
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

#  AUR packages
yay -S --needed google-chrome nomacs cava discordo-git spotify-tui

#  Flatpak
yay -S --needed google-chrome nomacs cava discordo-git spotify-tui

# Catppuccin theme

mkdir wget
mkdir git

# Papirus Icons
cd wget
wget -qO- https://git.io/papirus-icon-theme-install | sh
cd ~

# Catppuccin Papirus Folders
cd git
git clone https://github.com/catppuccin/papirus-folders.git catppuccin-papirus-folders && cd catppuccin-papirus-folders

cp -r src/* /usr/share/icons/Papirus
papirus-folders -C cat-macchiato-lavender --theme Papirus

cd ~

# Catppuccin KDE
cd git
git clone https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde

./install.sh

cd ~

# Catppuccin BTOP
cd git
git clone https://github.com/catppuccin/btop catppuccin-btop && cd catppuccin-btop

mkdir -p ~/.config/btop/themes && cp -r themes ~/.config/btop

cd ~


# Catppuccin BTOP
cd git
git clone https://github.com/catppuccin/cava.git catppuccin-cava && cd catppuccin-cava

mkdir -p ~/.config/cava/themes && cp -r themes/macchiato.cava ~/.config/cava/themes

cd ~
