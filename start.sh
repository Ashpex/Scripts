#!/bin/sh
xrandr --output HDMI-2 --mode 2560x1440 --rate 59.95 --primary --left-of eDP-1  --output eDP-1 --mode 1920x1080
feh --bg-fill ~/Downloads/wallpapers/car.jpg
pkill conky
conky -d
