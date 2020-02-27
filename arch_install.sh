#!/bin/bash

# WARNING: this script will destroy data on the selected disk.
# This script can be run by executing the following:
#   curl -sL https://..... | bash
# This script requires a package called "dialog" to work. Normally, it's already installed in arch iso.
# if not then install it first.

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Get infomation from user ###
hostname=$(dialog --stdout --inputbox "Enter hostname" 0 0) || exit 1
clear
: ${hostname:?"hostname cannot be empty"}

user=$(dialog --stdout --inputbox "Enter admin username" 0 0) || exit 1
clear
: ${user:?"user cannot be empty"}

password=$(dialog --stdout --passwordbox "Enter admin password" 0 0) || exit 1
clear
: ${password:?"password cannot be empty"}
password2=$(dialog --stdout --passwordbox "Enter admin password again" 0 0) || exit 1
clear
[[ "$password" == "$password2" ]] || ( echo "Passwords did not match"; exit 1; )

### Setting wifi ###
# Delete this if you don't require wifi network to set up.
echo "========================================================================================="
echo "Setting up wifi"
echo "========================================================================================="
ip link
wifi-menu

### Getting disk information ###

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

### Set up logging ###
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")

### Real time setup ###
timedatectl set-ntp true

### Setup the disk and partitions ###
#swap_size=$(free --mebi | awk '/Mem:/ {print $2}')
echo "========================================================================================="
echo "Setting disk partition"
echo "========================================================================================="
swap_size=40000
swap_end=$(( $swap_size + 512 + 1 ))MiB

parted --script "${device}" -- mklabel gpt \
  mkpart ESP fat32 1Mib 512MiB \
  set 1 boot on \
  mkpart primary linux-swap 512MiB ${swap_end} \
  mkpart primary ext4 ${swap_end} 100%

part_boot="$(ls ${device}* | grep -E "^${device}p?1$")"
part_swap="$(ls ${device}* | grep -E "^${device}p?2$")"
part_root="$(ls ${device}* | grep -E "^${device}p?3$")"

mkfs.fat -F32 "${part_boot}"
mkswap "${part_swap}"
swapon "${part_swap}"
mkfs.ext4 "${part_root}"
mount "${part_root}" /mnt
mkdir /mnt/boot
mount "${part_boot}" /mnt/boot

### Install and configure the basic system ###

# you can find your closest server from: https://www.archlinux.org/mirrorlist/all/
echo "========================================================================================="
echo "Basic system setup"
echo "========================================================================================="
echo 'Server = http://mirrors.evowise.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-firmware neovim
genfstab -U /mnt
genfstab -U /mnt >> /mnt/etc/fstab
echo "${hostname}" > /mnt/etc/hostname
arch-chroot /mnt useradd -g users -G wheel,storage,power -m "$user"
echo "$user:$password" | chpasswd --root /mnt
echo "root:$password" | chpasswd --root /mnt

### Set up locale ###

arch-chroot /mnt
echo "$user ALL=(ALL) ALL" > /etc/sudoers
echo "en_US.UFT-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UFT-8" > /etc/locale.conf
localectl set-locale LANG=en_US.UTF-8

### Setting up Bootloader ###
echo "========================================================================================="
echo "Setting up Bootloader"
echo "========================================================================================="
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

### Setting up network###
echo "========================================================================================="
echo "Setting up network"
echo "========================================================================================="
pacman -S networkmanager wireless_tools wpa_supplicant network-manager-applet

echo "Done. Rebooting...."
exit
reboot
