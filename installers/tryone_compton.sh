#!/bin/bash

# Ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@" "sudo"
  exit $?
fi

# Install dependencies
sudo apt install -y libconfig-dev asciidoc

git clone --depth 1 https://github.com/tryone144/compton.git /tmp/compton
cd /tmp/compton

# Continue with rofi installation
make
make docs
make install
