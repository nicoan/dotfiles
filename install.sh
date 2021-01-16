#!/bin/bash
if [ "$1" != "sudo" ]; then
  echo -e "Choose an installing option:\n1) Desktop Work\n2) Desktop Home\n3) Laptop"
  read option
  if [ $option == "1" ]; then
    DEVICE_CONFIG_DIR="dotfiles/desktop_work_config"
  elif [ $option == "2" ]; then
    DEVICE_CONFIG_DIR="dotfiles/desktop_home_config"
  elif [ $option == "3" ]; then
    DEVICE_CONFIG_DIR="dotfiles/laptop_config"
  else
    echo "Invalid option"
    exit 1
  fi

  CURRENT_DIR=`pwd`
  FONT_DIR=$HOME/.fonts/
  CONFIG_DIR=$HOME/.config/
  EXECUTABLES_DIR=$HOME/.local/bin/

  # Create directories
  echo "Creating directories..."
  if [ ! -d "$FONT_DIR" ]; then
    mkdir "$FONT_DIR"
  fi

  if [ ! -d "$CONFIG_DIR" ]; then
    mkdir "$CONFIG_DIR"
  fi

  if [ ! -d "$EXECUTABLES_DIR" ]; then
    mkdir "$EXECUTABLES_DIR"
  fi

  # Copy configs
  echo "Copyting resources and configs..."
  cp -rf "$CURRENT_DIR/$DEVICE_CONFIG_DIR/.config/." "$HOME/.config/"
  cp "$CURRENT_DIR/$DEVICE_CONFIG_DIR/.Xresources" "$HOME/.Xresources"
  cp "$CURRENT_DIR/$DEVICE_CONFIG_DIR/.bashrc" "$HOME/.bashrc"
  cp "$CURRENT_DIR/$DEVICE_CONFIG_DIR/.profile" "$HOME/.profile"
  cp -rf "$CURRENT_DIR/.bin/." "$EXECUTABLES_DIR"
  bash "$CURRENT_DIR/fonts/install.sh"

  # Execution and ownerships of useful scripts
  chmod -R +x "$HOME/.config/bash-imports"
  chmod -R +x "$HOME/.config/i3blocks/"
  chmod -R +x "$HOME/.config/rofi/scripts/"

  # Ask for sudo
  if [ $EUID != 0 ]; then
    sudo "$0" "$@" "sudo"
    exit $?
  fi

else
  # Programs

  # APT
  echo "Installing packages..."
  apt-get update
  apt-get install -y xclip \
    rxvt \
    compton \
    feh \
    scrot \
    lm-sensors \
    redshift \
    gtk-redshift \
    alsa-utils \
    pavucontrol \
    xautolock \
    xbacklight \
    dunst \
    imagemagick \
    git \
    vim \
    htop \
    xcowsay \
    build-essential \
    shtool \
    curl\
    snap \
    wget \
    ripgrep \
    udiskie \
    lxpolkit \
    blueman \
    wmctrl \

  # Snaps
  snap install core

  snap install keepasssxc
  snap disconnect keepassxc:network :network
  snap disconnect keepassxc:network-bind :network-bind

  snap install rambox
  snap install codium
  snap install rambox

  # i3-gaps
  bash ./installers/i3gaps.sh

  # i3-blocks gaps
  bash ./installers/i3blocks_gaps.sh

  # i3lock-color
  bash ./installers/i3lock_color.sh

  # GTK Theme
  bash ./installers/gtk_theme.sh

  # Icons theme
  bash ./installers/icon_theme.sh

  # Rofi
  bash ./installers/rofi.sh

  # Tryone compton
  bash ./installers/tryone_compton.sh

  # Reset MS Mice (Microsoft mouse wheel fixer)
  # (only on desktop)
  if [[ $option == "1"  || $option == "2" ]]; then
    bash ./installers/resetmsmice.sh
  fi

  # Done
  echo "It's done! :)"
  echo "Reboot the system? [Y/n]"
  read option
  if [ "$option" == "n" ]; then
    exit 0
  else
    reboot
  fi
fi
