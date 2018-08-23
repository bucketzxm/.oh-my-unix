alias aa='apt-get install '
alias co='git checkout '
alias ec='emacsclient -c'
alias grep='grep --color=always '
alias ls='ls --color=auto '
alias rm='rmtrash'
alias rmdir='rmdirtrash'
alias sudo='sudo'
alias grep='grep --color=always'
alias diff='colordiff'

if [ -x "$(command -v bat)" ]; then
    alias cat="bat"
fi



export PATH="$HOME/.cargo/bin:$PATH"
