# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=/Users/jwoolgar/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k" # agnoster
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666"
DEFAULT_USER="jwoolgar"

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
export PATH=/usr/local/Cellar/node/12.12.0/bin/:$PATH # why?

alias {vim,vi,im}="nvim"
alias zshrc="nvim ~/dotfiles/.zshrc"
alias webdis="cd ~/dev/webdis ; ./webdis & ; cd -"

# whats on the port?
listening() {
  if [ $# -eq 0 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P | grep $1
  fi
}

# load nvm and switch version
use_nvm() {
  NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm use $1
}

# load p10k config
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles.p10k.zsh
