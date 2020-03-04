#!/usr/bin/env bash

options="


"
themes_dir=$HOME/.config/rofi/themes
theme=${1:-$themes_dir/powermenu.rasi}
selection=$(echo -e "${options}" | rofi -dmenu -p -theme themes/powermenu.rasi -normal-window)

echo "This is your selection: $selection"

case "${selection}" in
    "")
        systemctl poweroff -i;;
    "")
        systemctl reboot;;
    "")
        i3-msg exit;;
    "")
        $HOME/.config/i3/lock_and_blur.sh;;
esac
