#!/bin/bash

# Ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@" "sudo"
  exit $?
fi

sudo apt install -y libxcb1-dev \
  libxcb-shape0-dev \
  libxcb-keysyms1-dev \
  libpango1.0-dev libxcb-util0-dev \
  libxcb-icccm4-dev \
  libyajl-dev \
  libstartup-notification0-dev \
  libxcb-randr0-dev \
  libev-dev \
  libxcb-cursor-dev \
  libxcb-xinerama0-dev \
  libxcb-xkb-dev \
  libxkbcommon-dev \
  libxkbcommon-x11-dev \
  autoconf \
  libxcb-xrm0 \
  libxcb-xrm-dev \
  automake \
  meson \
  asciidoc

# clone the repository
git clone --branch 4.19.1 --depth 1 https://www.github.com/Airblader/i3 /tmp/i3-gaps
cd /tmp/i3-gaps

mkdir build

meson -Ddocs=true -Dmans=true ./build
meson compile -C ./build
meson install -C ./build

