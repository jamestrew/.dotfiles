# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:$HOME/go/bin:$HOME/apps/neovim/bin:$PATH
export CDPATH=$HOME/.local/share/nvim/:$CDPATH
export EDITOR='nvim'


# source $ZSH/oh-my-zsh.sh


alias cat="bat"
alias ll="ls -lah"

eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"

gch() {
 git checkout "$(git branch --all | fzf| tr -d '[:space:]')"
}



source ~/.secrets
ta
