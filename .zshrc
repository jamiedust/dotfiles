DEFAULT_USER=$USER
export ZSH=/Users/jamiewoolgar/.oh-my-zsh

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
  macos
  zsh-autosuggestions
  dotenv
)

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:$HOME/Library/Python/3.9/bin

# Disable create-react-app auto launch
export BROWSER=none

# https://github.com/Schniz/fnm
eval "$(fnm env)"

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias {vim,vi,im}="nvim"
alias zshrc="nvim ~/dotfiles/.zshrc"

gch() {
  git checkout $1 2>/dev/null || git checkout -b $1;
}

# function to check what process is listening on a port
listening() {
  if [ $# -eq 0 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P | grep $1
  fi
}
