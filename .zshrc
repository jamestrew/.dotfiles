# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/apps/neovim/bin:$PATH
export CDPATH=$HOME/.local/share/nvim/:$CDPATH
export EDITOR='nvim'

alias cat="bat"
alias ll="ls -lah"

eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"

source ~/.secrets # find a better way, git-crypt maybe?
ta
