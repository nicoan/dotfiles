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
  EXECUTABLES_DIR=$HOME/.bin/

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
  echo "Installing packages..."
  apt-get install -y xclip \
    rxvt \
    rxvt-unicode \
    rxvt-unicode-256color \
    compton \
    rofi \
    feh \
    scrot \
    lm-sensors \
    redshift \
    pavucontrol \
    xautolock \
    xbacklight \
    dunst \
    imagemagick \
    git \
    vim \
    htop \
    xcowsay \
    deboprhan \

  # i3-gaps
  bash ./i3-gaps.sh

  # i3-blocks gaps
  bash ./i3blocks-gaps.sh

  # i3lock-color
  bash ./i3lock-color.sh

  # GTK Theme
  bash ./gtk-theme.sh

  # Icons theme
  bash ./icon-theme.sh

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
