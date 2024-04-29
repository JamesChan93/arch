#! /bin/bash
# Execute at install.sh level

# Base Linux Kernels and Microcode
pacstrap -K /mnt intel-ucode base linux linux-firmware linux-lts

# Fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Localization
cp ./confs/locale.gen /etc/locale.gen
echo LANG=en_GB.UTF-8 >> /etc/locale.conf
echo KEYMAP=uk >> /etc/vconsole.conf

# Hostname
echo archbtw >> /etc/hostname
