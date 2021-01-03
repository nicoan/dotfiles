#!/bin/bash
# Ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@" "sudo"
  exit $?
fi

# Install dependencies
apt install -y libusb-1.0 libgtk2.0-dev

# Clone project
git clone --depth 1 https://github.com/paulrichards321/resetmsmice.git /tmp/resetmsmice

cd /tmp/resetmsmice
./configure
make
make install
cd -
