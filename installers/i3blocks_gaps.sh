pushd /tmp
git clone https://github.com/Airblader/i3blocks-gaps i3blocks
cd i3blocks
make clean all
make
make install
popd
