#! /bin/bash

# Timezone set
sudo timedatectl set-timezone Europe/London

# Update
sudo pacman -Syu

# pacman config
sudo cp ./confs/pacman.conf /etc/pacman.conf

# Reflector
sudo pacman -S --needed reflector
echo "Making a backup of the mirror list"
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Completed"

sudo reflector --country 'GB' --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Superuser support
sudo pacman -S --needed sudo

# Security
sudo pacman -S --needed ufw
sudo ufw enable
sudo systemctl enable ufw.service

# Package Cleaning
sudo pacman -S pacman-contrib
sudo systemctl enable paccache.timer

# Base Development tools
sudo pacman -S --needed base-devel git wget

# Video Drivers
sudo pacman -S --needed intel-media-driver

# Audio Drivers
sudo pacman -S --needed pipewire wireplumber pipewire-pulse pipewire-alsa

# DE
sudo pacman -S --needed plasma-desktop plasma-nm plasma-pa kscreen

# Display Manager
sudo pacman -S --needed sddm
sudo systemctl enable sddm.service

# CLI/TUI applications
sudo pacman -S --needed kitty nano fastfetch btop powertop  spotifyd cmatrix

#  Fonts
sudo pacman -S --needed noto-fonts-* ttf-hack  powerline-fonts

#  Applications
sudo pacman -S --needed firefox thunderbird code p7zip nano dolphin spectacle discord

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

sudo cp -r src/* /usr/share/icons/Papirus
sudo papirus-folders -C cat-macchiato-lavender --theme Papirus

cd ~

# Catppuccin KDE
cd git
git clone https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde

./install.sh

cd ~

# Catppuccin BTOP
cd git
git clone https://github.com/catppuccin/btop catppuccin-btop && cd catppuccin-btop

sudo mkdir -p ~/.config/btop/themes && cp -r themes ~/.config/btop

cd ~


# Catppuccin BTOP
cd git
git clone https://github.com/catppuccin/cava.git catppuccin-cava && cd catppuccin-cava

sudo mkdir -p ~/.config/cava/themes && cp -r themes/macchiato.cava ~/.config/cava/themes

cd ~
