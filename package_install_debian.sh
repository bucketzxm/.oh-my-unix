export OHMYUNIXROOT=`pwd`
sudo apt-get update && apt-get upgrade
git submodule update --init

# compile cquery
cd 3rdparty/cquery
git submodule update --init && ./waf configure build # --variant=debug if you want to report issure
export PATH=$PATH:`pwd`/build/release/bin/

# install rust if you want
# curl https://sh.rustup.rs -sSf | sh

# install ccache to speed up compiling same c++ files
sudo apt-get install ccache

cd $OHMYUNIXROOT
mkdir ~/.config_backup
export CONFIG_BACKUP_PATH=~/.config_backup
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/$CONFIG_BACKUP_PATH/.bashrc
fi

ln -s .bashrc ~/.bashrc


if [ -f ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/$CONFIG_BACKUP_PATH/.bash_aliases
fi
ln -s .bash_aliases ~/.bash_aliases

if [ -f ~/.bash_profile]; then
   mv ~/.bash_profile ~/$CONFIG_BACKUP_PATH/.bash_profile
fi
ln -s .bash_profile ~/.bash_aliases

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/$CONFIG_BACKUP_PATH/.zshrc
fi
ln -s .zshrc ~/.zshrc




