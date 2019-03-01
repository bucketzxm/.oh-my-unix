set -e

sudo apt-get update && sudo apt-get upgrade
git submodule update --init

# install rust if you want
# curl https://sh.rustup.rs -sSf | sh

# install ccache to speed up compiling same c++ files
sudo apt-get install ccache cmake build-essential
source ./package_install_compile.sh

sudo apt-get install colordiff
sudo apt-get install silversearcher-ag
sudo apt-get install netcat-openbsd smartmontools
sudo apt-get install emacs-goodies-el curl git okular needrestart

sudo apt-get install terminator pv

#For correctly reformatting and reindenting c++ code (mandatory for C++ dev):
sudo apt-get install uncrustify
cd $HOME; wget https://redmine.mujin.co.jp/attachments/download/128/.uncrustify.cfg
# gnome flash back
sudo apt-get install gnome-session-flashback gnome-panel gnome-panel-control xfce4-terminal
sudo update-alternatives --install /etc/alternatives/x-session-manager gnome-flashback-metacity /usr/lib/gnome-flashback/gnome-flashback-metacity 99

sudo apt-get install clearlooks-phenix-theme
gsettings set org.gnome.metacity.theme type metacity
gsettings set org.gnome.metacity.theme name Clearlooks-Phenix

# choose terminal
sudo update-alternatives --config x-terminal-emulator
