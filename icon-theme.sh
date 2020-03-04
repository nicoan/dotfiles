pushd /tmp
git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git --depth 1
pushd papirus-icon-theme

echo "Installing theme..."

$(pwd)/install.sh --prefix=/usr

echo "Aplying theme..."
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

popd
