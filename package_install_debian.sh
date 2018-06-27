set -e
export OHMYUNIXROOT=`pwd`
sudo apt-get update && sudo apt-get upgrade
git submodule update --init

# compile cquery
cd 3rdparty/cquery
git submodule update --init && ./waf configure build # --variant=debug if you want to report issure
export PATH=$PATH:`pwd`/build/release/bin/

# install rust if you want
# curl https://sh.rustup.rs -sSf | sh

# install ccache to speed up compiling same c++ files
sudo apt-get install ccache

export DATE=`date '+%Y-%m-%d%H%M%S'`
cd $OHMYUNIXROOT
export CONFIG_BACKUP_PATH=~/.config_backup
if [ -d $CONFIG_BACKUP_PATH ]; then
    tar cvf ~/$CONFIG_BACKUP_PATH$DATE.tar.gz CONFIG_BACKUP_PATH
else
    mkdir $CONFIG_BACKUP_PATH
fi


if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/$CONFIG_BACKUP_PATH/.bashrc
fi
ln -s .bashrc ~/.bashrc

if [ -f ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/$CONFIG_BACKUP_PATH/.bash_aliases
fi
ln -s .bash_aliases ~/.bash_aliases

if [ -f ~/.bash_profile ]; then
   mv ~/.bash_profile ~/$CONFIG_BACKUP_PATH/.bash_profile
fi
ln -s .bash_profile ~/.bash_aliases

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/$CONFIG_BACKUP_PATH/.zshrc
fi
ln -s .zshrc ~/.zshrc




