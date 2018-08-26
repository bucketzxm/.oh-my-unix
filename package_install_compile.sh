set -e
export OHMYUNIXROOT=`pwd`
# compile cquery
cd 3rdparty

# may need to specify clang path, see ./waf configure --help
# git submodule update --init && ./waf configure build # --variant=debug if you want to report issure
# export PATH=$PATH:`pwd`/build/release/bin/

# install or update fzf
sh fzf/install.sh

export DATE=`date '+%Y-%m-%d%H%M%S'`
cd $OHMYUNIXROOT
export CONFIG_BACKUP_PATH=~/.config_backup
if [ -d $CONFIG_BACKUP_PATH ]; then
    tar cvf ~/config_backup$DATE.tar.gz $CONFIG_BACKUP_PATH
else
    mkdir $CONFIG_BACKUP_PATH
fi

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv


function check_link(){
    my_link=$1
    if [ -L ${my_link} ] ; then
        if [ -e ${my_link} ] ; then
            echo "Good link"
            return 0
        else
            echo "Broken link"
        fi
    elif [ -e ${my_link} ] ; then
        echo "Not a link"
        return 1
    else
        echo "File $my_link does not exist"
        return 1
    fi
}


CONFIG_FILES=""
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc $CONFIG_BACKUP_PATH/.bashrc
fi

if ! check_link ~/.bashrc ; then
    ln -s $OHMYUNIXROOT/.bashrc ~/.bashrc
fi


if [ -f ~/.bash_aliases ]; then
    mv ~/.bash_aliases $CONFIG_BACKUP_PATH/.bash_aliases
fi

if ! check_link ~/.bash_aliases ; then
    ln -s $OHMYUNIXROOT/.bash_aliases ~/.bash_aliases
fi

if [ -f ~/.profile ]; then
    mv ~/.profile $CONFIG_BACKUP_PATH/.profile
fi

if ! check_link ~/.profile ; then
    ln -s $OHMYUNIXROOT/.profile ~/.profile
fi

if [ -f ~/.bash_profile ]; then
   mv ~/.bash_profile $CONFIG_BACKUP_PATH/.bash_profile
fi
if ! check_link ~/.bash_profile ; then
    ln -s $OHMYUNIXROOT/.bash_profile ~/.bash_profile
fi


if [ -f ~/.zshrc ]; then
    mv ~/.zshrc $CONFIG_BACKUP_PATH/.zshrc
fi

if ! check_link ~/.zshrc ; then
    ln -s  $OHMYUNIXROOT/.zshrc ~/.zshrc
fi

if ! check_link ~/.fzf.bash ; then
	ln -s $OHMYUNIXROOT/.fzf.bash ~/.fzf.bash
fi

# rm backup path
rm -rf $CONFIG_BACKUP_PATH

curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git



echo "end of package_install_compile.sh"




