# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/.local/share/nvim/mason/bin:$HOME/apps/neovim/bin:$PATH
export CDPATH=$HOME/.local/share/nvim/:$CDPATH

# Path to your oh-my-zsh installation.
# export ZSH="~/.oh-my-zsh"
plugins=(
    # git
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # fzf
)

source $ZSH/oh-my-zsh.sh


export EDITOR='nvim'

alias cat="bat"
alias ll="ls -lah"

eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"

gch() {
 git checkout "$(git branch --all | fzf| tr -d '[:space:]')"
}

testing() {
  mkdir -p /tmp/testing
  cd /tmp/testing
  cp ~/.config/nvim/minimal_init.lua /tmp/testing/min.lua
}

export DOCGEN_PATH=$HOME/projects/docgen.nvim

source ~/.secrets
ta
