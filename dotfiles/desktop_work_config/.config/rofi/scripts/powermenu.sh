#!/bin/bash
function peaceful-close-apps {
  for win in $(wmctrl -l | awk '{print $1}'); do
    wmctrl -i -c $win
  done
}

options="


"
themes_dir=$HOME/.config/rofi/themes
theme=${1:-$themes_dir/powermenu.rasi}
selection=$(echo -e "${options}" | rofi -dmenu -p -theme themes/powermenu.rasi -normal-window)

echo "This is your selection: $selection"

case "${selection}" in
    "")
        peaceful-close-apps
        systemctl poweroff -i
      ;;
    "")
        peaceful-close-apps
        systemctl reboot
      ;;
    "")
        i3-msg exit;;
    "")
        $HOME/.config/i3/lock_and_blur.sh;;
esac
