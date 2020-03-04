#!/bin/bash
apt-get install -y pkg-config \
libxcb1 \
libpam-dev \
libcairo-dev \
libxcb-composite0 \
libxcb-composite0-dev \
libxcb-xinerama0-dev \
libev-dev \
libx11-dev \
libx11-xcb-dev \
libxkbcommon0 \
libxkbcommon-x11-0 \
libxcb-dpms0-dev \
libxcb-image0-dev \
libxcb-util0-dev \
libxcb-xkb-dev \
libxkbcommon-x11-dev \
libxkbcommon-dev \
libjpeg-dev \

cd /tmp

git clone https://github.com/PandorasFox/i3lock-color.git
cd i3lock-color

# pushd ./sources/i3lock-color
# make && make install
# popd

autoreconf --force --install

rm -rf build/
mkdir -p build && cd build/

../configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --disable-sanitizers

make
make install
