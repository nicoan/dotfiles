#!/bin/bash

# Ask for sudo
if [ $EUID != 0 ]; then
  sudo "$0" "$@" "sudo"
  exit $?
fi


git clone --recursive --depth 1 --branch 1.6.1 https://github.com/davatorium/rofi /tmp/rofi
cd /tmp/rofi
autoreconf -i
mkdir build
cd build
cd ..

# Dependencies
sudo apt install -y bison \
  flex \
  libxcb-ewmh-dev \
  librsvg2-dev \
  texinfo \
  libtool

# Install lastest check (0.10.0 available in ubuntu 18.04)
git clone https://github.com/libcheck/check.git /tmp/check
pushd /tmp/check
autoreconf --install
./configure
make
make check
make install
ldconfig
popd


# Continue with rofi installation
./configure
make
make install
