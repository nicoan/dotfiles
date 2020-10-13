pushd /tmp
git clone https://github.com/horst3180/arc-theme --depth 1

pushd arc-theme

echo "Installing theme..."
sudo apt-get install -y libgtk-3-dev
$(pwd)/autogen.sh --prefix=/usr
sudo make install

echo "Aplying theme..."
gsettings set org.gnome.desktop.wm.preferences theme "Ark-Darker"
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Darker"

popd
