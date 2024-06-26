#! /bin/bash
# Script should be executed at install.sh level

# Timezone set
sudo timedatectl set-timezone Europe/London

# Update
sudo pacman -Syu

# pacman config
sudo cp packages/confs/pacman.conf /etc/pacman.conf

# Reflector
sudo pacman -S --needed reflector
echo "Making a backup of the mirror list"
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Completed"

sudo reflector --country 'GB' --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Superuser support
sudo pacman -S --needed grub efibootmgr os-prober

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
sudo pacman -S --needed plasma-desktop plasma-nm plasma-pa kscreen plasma-browser-integration kde-gtk-config breeze-gtk

# Display Manager
sudo pacman -S --needed sddm
sudo systemctl enable sddm.service

# CLI/TUI applications
sudo pacman -S --needed kitty nano fastfetch btop powertop spotifyd cmatrix

#  Fonts
sudo pacman -S --needed noto-fonts-* noto-fonts-cjk ttf-hack powerline-fonts

#  Applications
sudo pacman -S --needed firefox thunderbird code p7zip unzip nano dolphin spectacle discord

# Install AUR helper
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

#  AUR packages
yay -S --needed google-chrome nomacs cava discordo-git spotify-tui

#  Flatpak
yay -S --needed google-chrome nomacs cava discordo-git spotify-tui

# Catppuccin theme
cd ~
mkdir wget
mkdir git

# Papirus Icons
cd wget
wget -qO- https://git.io/papirus-icon-theme-install | sh
cd ~

# Catppuccin Papirus Folders
cd git

git clone https://github.com/catppuccin/papirus-folders.git catppuccin-papirus-folders
cd catppuccin-papirus-folders
sudo cp -r src/* /usr/share/icons/Papirus
sudo ./papirus-folders -C cat-frappe-lavender --theme Papirus

cd ~

# Catppuccin KDE
cd git

git clone https://github.com/catppuccin/kde catppuccin-kde
cd catppuccin-kde
./install.sh

cd ~

# Catppuccin BTOP
cd git

git clone https://github.com/catppuccin/btop catppuccin-btop
cd catppuccin-btop
mkdir -p ~/.config/btop/themes 
cp -r themes ~/.config/btop

cd ~

# Catppuccin BTOP
cd git

git clone https://github.com/catppuccin/cava.git catppuccin-cava 
cd catppuccin-cava
mkdir -p ~/.config/cava/themes
cp -r themes/frappe.cava ~/.config/cava/themes

cd ~

# Catppuccin GRUB
cd git

git clone https://github.com/catppuccin/grub.git catppuccin-grub
cd catppuccin-grub
sudo cp -r src/* /usr/share/grub/themes/

cd ~

# Catppuccin Wallpapers
cd git

git clone https://github.com/Gingeh/wallpapers.git catppuccin-wallpapers
cd catppuccin-wallpapers
sudo mkdir -p /usr/share/wallpapers/catppuccin
sudo cp -r * /usr/share/wallpapers/catppuccin

cd ~

# Catppuccin sddm WIP
sudo pacman -S --needed qt6-svg qt6-declarative
sudo cp confs/sddm.conf /etc/

# Catppuccin Thunderbird WIP
cd git

git clone https://github.com/catppuccin/thunderbird.git catppuccin-thunderbird

cd ~