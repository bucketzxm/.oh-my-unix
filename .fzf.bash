# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mujin/.oh-my-unix/3rdparty/fzf/bin* ]]; then
  export PATH="$PATH:/home/mujin/.oh-my-unix/3rdparty/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mujin/.oh-my-unix/3rdparty/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mujin/.oh-my-unix/3rdparty/fzf/shell/key-bindings.bash"

