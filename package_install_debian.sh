set -e

SERVER_MODE=$1

sudo apt-get update && sudo apt-get upgrade
git submodule update --init

# install rust if you want
# curl https://sh.rustup.rs -sSf | sh

# install ccache to speed up compiling same c++ files
sudo apt-get install ccache cmake build-essential

sudo apt-get install colordiff
sudo apt-get install silversearcher-ag
sudo apt-get install netcat-openbsd smartmontools
sudo apt-get install emacs-goodies-el curl git okular needrestart

sudo apt-get install terminator pv meld autoconf

sudo apt-get install xclip

# install font for emacs
sudo apt install fonts-firacode

# pyenv recommanded
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev


# install gnutls for emacs
sudo apt-get install libgnutls28-dev

# fix makeinfo
# In (at least) Ubuntu when using bash, it tells you what package you need to install if you type in a command and its not found in your path. My terminal says you need to install 'texinfo' package. from stackoverflow(https://stackoverflow.com/questions/338317/what-is-makeinfo-and-how-do-i-get-it)
sudo apt-get install texinfo

#For correctly reformatting and reindenting c++ code (mandatory for C++ dev):
sudo apt-get install uncrustify
# add () to make `cd` temporatily
(cd $HOME; wget https://redmine.mujin.co.jp/attachments/download/128/.uncrustify.cfg)

if [ -z ${SERVER_MODE} ]; then
    # gnome flash back
    sudo apt-get install gnome-session-flashback gnome-panel gnome-panel-control xfce4-terminal
    sudo update-alternatives --install /etc/alternatives/x-session-manager gnome-flashback-metacity /usr/lib/gnome-flashback/gnome-flashback-metacity 99

    sudo apt-get install clearlooks-phenix-theme
    gsettings set org.gnome.metacity.theme type metacity
    gsettings set org.gnome.metacity.theme name Clearlooks-Phenix
fi

# choose terminal
sudo update-alternatives --config x-terminal-emulator


# install docker
# uninstall old version first
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io



# emacs elpy 
# https://github.com/jorgenschaefer/elpy

# ubuntu limited
release_distribution=`lsb_release -d | awk '{ print $2 }'`
if [ release_distribution = 'Ubuntu' ]; then
    sudo apt-get install elpa-elpy
fi

# install 3rdparty packages
source ./package_install_compile.sh

