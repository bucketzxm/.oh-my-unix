set -e
export OHMYUNIXROOT=`pwd`
# compile cquery
cd 3rdparty

# may need to specify clang path, see ./waf configure --help
# git submodule update --init && ./waf configure build # --variant=debug if you want to report issure
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


CONFIG_FILES=".bashrc .bash_aliases .profile .bash_profile .gdbinit .fzf.bash"

for FILE in $CONFIG_FILES:
do
	mv ~/${FILE} $CONFIG_BACKUP_PATH/${FILE}
	ln -s $OHMYUNIXROOT/${FILE} ~/${FILE}
done

# rm backup path
# rm -rf $CONFIG_BACKUP_PATH

curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git

# install or update fzf
cd $OHMYUNIXHOME/3rdpart
sh fzf/install.sh


echo "end of package_install_compile.sh"




