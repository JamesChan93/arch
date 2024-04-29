#! /bin/bash
# Execute at chroot.sh level whilst chrooted into Arch install

#Time
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

# Localization
locale-gen

# root password
echo "Please enter a password for root"
passwd

# Users
useradd -m -G wheel james

# Passwords
echo "Please enter a password for james"
passwd james

# Sync
pacman -Syu

# Reflector
pacman -S --needed reflector
echo "Making a backup of the mirror list"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Completed"
reflector --country 'GB' --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Install Grub
pacman -S --needed grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Network
pacman -S --needed networkmanager
systemctl enable NetworkManager.service
