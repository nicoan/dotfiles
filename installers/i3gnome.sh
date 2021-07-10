#!/bin/bash
gsettings set org.gnome.gnome-flashback desktop false
gsettings set org.gnome.gnome-flashback root-background true

# Ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@" "sudo"
  exit $?
fi

# clone the repository
git clone --branch 3.38.0 --depth 1 https://github.com/i3-gnome/i3-gnome.git /tmp/i3-gnome
cd /tmp/i3-gnome

make install
