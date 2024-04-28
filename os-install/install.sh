#! /bin/bash

# Sync
pacman -Syy

# Reflector
pacman -S --needed reflector
echo "Making a backup of the mirror list"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Completed"


reflector --country 'GB' --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Base Linux Kernels and Microcode
pacstrap -K /mnt intel-ucode base linux linux-firmware linux-lts

# Fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot
arch-chroot /mnt

#Time
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

# Localization
cp ./confs/locale.gen /etc/locale.gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf
locale-gen
echo KEYMAP=uk >> /etc/vconsole.conf

# Hostname
echo archbtw >> /etc/hostname

# root password
echo "Please enter a password for root"
passwd

# Users
useradd -m -G wheel james

# Passwords
echo "Please enter a password for james"
passwd james

# Install Grub
pacman -S --needed grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --needed networkmanager
systemctl enable NetworkManager.Service

exit

echo "Chroot ended"