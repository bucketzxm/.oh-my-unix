# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export HOME_OHMYUNIX=$HOME/.oh-my-unix

[[ "$XDG_CURRENT_DESKTOP" == "KDE" ]] || export QT_QPA_PLATFORMTHEME="qt5ct"

if [ -d $HOME_OHMYUNIX ]; then
    source $HOME_OHMYUNIX/tool_functions.sh
fi

# install trach-cli
if ! [ -x "$(command -v trash-put)" ]; then
    cd $HOME_OHMYUNIX/3rdparty/trash-cli
    sudo python $HOME_OHMYUNIX/3rdparty/trash-cli/setup.py install
fi


# check rmtrash
if ! [ -x "$(command -v rmtrash)" ]; then
    sudo cp $HOME_OHMYUNIX/3rdparty/rmtrash/rmdirtrash /usr/local/bin
    sudo cp $HOME_OHMYUNIX/3rdparty/rmtrash/rmtrash /usr/local/bin
fi

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	      . $HOME/.bashrc
#     fi
# fi

# set PATH so it includes user's private bin if it exists
if [ -d $HOME/bin ] ; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -f $HOME/.mujin_profile ]; then
    source $HOME/.mujin_profile
fi

if [ -f $HOME/.bash_aliases ]; then
    if [ -L $HOME/.bash_aliases ]; then
        source `readlink -f $HOME/.bash_aliases`
    else
        source $HOME/.bash_aliases
    fi
fi


export GTAGSLABEL=pygments
export PATH="$HOME/.cargo/bin:$PATH"

# check if cargo and rust installed, and install some useful command
if [ -f $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
    if ! [ -x "$(command -v bat)" ]; then
        cargo install bat
    fi
    
fi


if [ -d $HOME_OHMYUNIX/3rdparty/cquery/build/release/bin ]; then
    export PATH=$HOME_OHMYUNIX/3rdparty/cquery/build/release/bin:$PATH
else
    echo "cquery not installed"
fi


export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GTAGSLABEL=pygments
