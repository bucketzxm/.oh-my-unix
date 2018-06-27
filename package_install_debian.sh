sudo apt-get update && apt-get upgrade
git submodule update --init

# compile cquery
cd 3rdparty/cquery
git submodule update --init && ./waf configure build # --variant=debug if you want to report issure
export PATH=$PATH:`pwd`/build/release/bin/


# install rust if you want
# curl https://sh.rustup.rs -sSf | sh




