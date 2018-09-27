set -e

sudo apt-get update && sudo apt-get upgrade
git submodule update --init

# install rust if you want
# curl https://sh.rustup.rs -sSf | sh

# install ccache to speed up compiling same c++ files
sudo apt-get install ccache

source ./package_install_compile.sh

sudo apt-get install colordiff

sudo apt-get install silversearcher-ag

sudo apt-get install netcat-openbsd smartmontools
