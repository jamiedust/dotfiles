export ZSH=/Users/jwoolgar/.oh-my-zsh

ZSH_THEME="agnoster"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666"

# ~/.oh-my-zsh/[custom]/plugins/
plugins=(
  git
  colored-man-pages
  colorize
  github
  docker
  brew
  osx
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $HOME/env.sh

export FZF_DEFAULT_COMMAND="rg --files --hidden --color=never -g '!.git/**'"

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools:$PATH

alias {vim,vi,im}="nvim"
alias zshrc="nvim ~/dotfiles/.zshrc"
alias webdis="cd ~/dev/utils/webdis ; ./webdis & ; cd -"

# function to check what process is listening on a port
listening() {
  if [ $# -eq 0 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P | grep $1
  fi
}

# https://github.com/Schniz/fnm
eval "$(fnm env)"
