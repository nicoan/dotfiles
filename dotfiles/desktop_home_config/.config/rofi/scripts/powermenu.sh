options="


"
themes_dir=$HOME/.config/rofi/themes
theme=${1:-$themes_dir/powermenu.rasi}
selection=$(echo "${options}" | rofi -dmenu -p -theme $theme -normal-window)

echo "This is your selection: $selection"

case "${selection}" in
    "")
        $HOME/.config/rofi/scripts/closeapps.sh
        rofi -e "Shuting down..." -theme $theme -normal-window &
        sleep 3
        systemctl poweroff -i
      ;;
    "")
        $HOME/.config/rofi/scripts/closeapps.sh
        rofi -e "Rebooting..." -theme $theme -normal-window &
        sleep 3
        systemctl reboot
      ;;
    "")
        $HOME/.config/rofi/scripts/closeapps.sh
        rofi -e "Logging out..." -theme $theme -normal-window &
        sleep 3
        i3 exit
      ;;
    "")
        dbus-send --type=method_call --dest=org.gnome.ScreenSaver  /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
      ;;
esac
