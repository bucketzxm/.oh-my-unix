# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it


if [ $0 == "zsh" ]; then
    if [ -f ~/.zshrc ]; then
       source ~/.zshrc
    fi
    # assume Zsh
elif [ $0 == "bash" ]; then
    # assume Bash
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    #shopt -s globstar


    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi


else
    # asume something else
    echo "not bash or shell"
fi



# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ -n "$BASH_VERSION" ]; then
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1) \$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1) \$ '
    fi
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir

if [ -n "$BASH_VERSION" ]; then
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

if [ -n "$BASH_VERSION" ]; then
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1) \$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1) \$ '
    fi
fi


xset -b # disable beep
export PATH=/usr/lib/ccache:$PATH



[[ $- != *i* ]] && return

colors() {
	  local fgc bgc vals seq0

	  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	  # foreground colors
	  for fgc in {30..37}; do
		    # background colors
		    for bgc in {40..47}; do
			      fgc=${fgc#37} # white
			      bgc=${bgc#40} # black

			      vals="${fgc:+$fgc;}${bgc}"
			      vals=${vals%%;}

			      seq0="${vals:+\e[${vals}m}"
			      printf "  %-9s" "${seq0:-(default)}"
			      printf " ${seq0}TEXT\e[m"
			      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		    done
		    echo; echo
	  done
}

[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc
if [[ -f ~/.profile ]]; then
    if [ -L $HOME/.bash_aliases ]; then
        source `readlink -f $HOME/.profile`
    else
        source $HOME/.profile
    fi
fi


if [[ -f ~/.bash_profile ]]; then
    if [ -L $HOME/.bash_profile ]; then
        source `readlink -f $HOME/.bash_profile`
    else
        source $HOME/.bash_profile
    fi
fi



[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

if [[ -f ~/.bashrc.mujin ]]; then
    source ~/.bashrc.mujin
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
