# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jwoolgar/.oh-my-zsh

ZSH_THEME=agnoster

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git colored-man-pages colorize github docker brew osx)

source $ZSH/oh-my-zsh.sh
# source "$HOME/set_env.sh"

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH

alias zshrc="nvim ~/dotfiles/.zshrc"
alias nvimrc="nvim ~/dotfiles/init.vim"
alias vim="nvim"
alias vi="nvim"

export FZF_DEFAULT_COMMAND="rg --files --hidden --color=never -g '!.git/**'"

listening() {
  if [ $# -eq 0 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P | grep $1
  fi
}
