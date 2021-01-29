### Install yay ###
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
### Install i3 ###

sudo pacman -S i3-gaps dunst dmenu picom feh mpd mpv ranger rofi scrot neovim xorg xorg-server pulseaudio pulseaudio-alsa alsa-utils nemo firefox git zathura
yay polybar
yay ranger-git

### Install from pkglist
git clone https://github.com/Ashpex/pkglist.git
sudo pacman -S - < pkglist.txt
sudo pacman -S $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
