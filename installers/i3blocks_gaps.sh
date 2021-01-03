#!/bin/bash
cd /tmp
git clone --depth 1 https://github.com/Airblader/i3blocks-gaps i3blocks
cd i3blocks
make clean all
make
make install
