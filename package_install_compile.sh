set -e
export OHMYUNIXROOT=`pwd`
# compile cquery
cd $OHMYUNIXROOT/3rdparty/cquery
git pull origin master
git submodule update --init
rm -rf build/
# setup new cmake build directory
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
make install -j8
# compile cquery end
# export PATH=$PATH:`pwd`/build/release/bin/

export DATE=`date '+%Y-%m-%d%H%M%S'`
cd $OHMYUNIXROOT
export CONFIG_BACKUP_PATH=~/.config_backup
if [ -d $CONFIG_BACKUP_PATH ]; then
    tar cvf ~/config_backup$DATE.tar.gz $CONFIG_BACKUP_PATH
else
    mkdir $CONFIG_BACKUP_PATH
fi

# install pyenv
if [ ! -d ~/.pyenv ]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

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


CONFIG_FILES=".bashrc .bash_aliases .profile .gdbinit"
for FILE in $CONFIG_FILES
do
    if [ -f ~/${FILE} ]; then
        mv ~/${FILE} $CONFIG_BACKUP_PATH/${FILE}
    fi
    ln -s $OHMYUNIXROOT/${FILE} ~/${FILE}
done

# rm backup path
# rm -rf $CONFIG_BACKUP_PATH
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git

# install or update fzf
cd $OHMYUNIXROOT/3rdparty
git pull origin master
fzf/install

# config for git alias
git config --global alias.co checkout
git config --global diff.tool meld

echo "end of package_install_compile.sh"
