# copy command output
# usage:  history | pclip
OS_NAME=$(uname)
function pclip {
    if [ $OS_NAME = "CYGWIN" ]; then
	      putclip "$@";
    elif [ $OS_NAME = "Darwin" ]; then
	      pbcopy "$@";
    else
	      if [ -x /usr/bin/xsel ]; then
	          xsel -ib "$@";
	      else
	          if [ -x /usr/bin/xclip ]; then
		            xclip -selection c "$@";
	          else
		            echo "Neither xsel or xclip is installed!"
	          fi
	      fi
    fi
}


# search history command in interactive  mode
# use percol command.

function exists() {
    which $1 &> /dev/null
}

function percol_select_history() {
	  local tac
	  (exists gtac) && tac="gtac" || (exists tac) && tac="tac" || tac="tail -r"
	  BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
	  CURSOR=$#BUFFER         # move cursor
	  zle -R -c               # refresh
}

# if ( exists percol ); then
#     zle -N percol_select_history
#     bindkey '^R' percol_select_history
# fi


# copy a file path under current path
function pwdf()
{
    local current_dir=`pwd`
    local copied_file=`find $current_dir -type f -print |percol`
    echo -n $copied_file |pclip;
}

