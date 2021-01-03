#!/bin/bash
pushd /tmp
git clone https://github.com/horst3180/arc-theme --depth 1

pushd arc-theme

echo "Installing theme..."
sudo apt-get install -y libgtk-3-dev
# NOTE FOR FUTURE SELF
# With gnome is there because a bug on gnome 3.24, remove if installation not working
$(pwd)/autogen.sh --prefix=/usr --with-gnome=3.22
sudo make install

echo "Aplying theme..."
gsettings set org.gnome.desktop.wm.preferences theme "Ark-Darker"
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Darker"

popd
