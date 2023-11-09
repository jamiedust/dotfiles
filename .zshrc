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
)

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:$HOME/Library/Python/3.11/bin
export PATH=/opt/homebrew/opt/openjdk@11/bin:$PATH
export PATH=$HOME/go/bin:$PATH

source ~/vars.sh

# https://github.com/Schniz/fnm
eval "$(fnm env)"

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias {vim,vi,im}="nvim"
alias zshrc="nvim ~/dotfiles/.zshrc"
alias python="python3.11"
alias pip="python3.11 -m pip"

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
