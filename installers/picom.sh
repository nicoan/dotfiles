#!/bin/bash

# Ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@" "sudo"
  exit $?
fi

rm -rf /tmp/picom
# Install dependencies
apt install -y libxext-dev \
  libxcb1-dev \
  libxcb-damage0-dev \
  libxcb-xfixes0-dev \
  libxcb-shape0-dev \
  libxcb-render-util0-dev \
  libxcb-render0-dev \
  libxcb-randr0-dev \
  libxcb-composite0-dev \
  libxcb-image0-dev \
  libxcb-present-dev \
  libxcb-xinerama0-dev \
  libxcb-glx0-dev \
  libpixman-1-dev \
  libdbus-1-dev \
  libconfig-dev \
  libgl1-mesa-dev \
  libpcre2-dev  \
  libevdev-dev \
  uthash-dev \
  libev-dev \
  libx11-xcb-dev \
  meson

git clone --depth 1 --branch vNext https://github.com/yshui/picom.git /tmp/picom
cd /tmp/picom

# Build
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build

# Install
ninja -C build install
