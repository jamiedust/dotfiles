export ZSH=/Users/jwoolgar/.oh-my-zsh

ZSH_THEME=agnoster

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git colored-man-pages colorize github docker brew osx)

source $ZSH/oh-my-zsh.sh
source $HOME/env.sh

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/Library/Android/sdk/tools:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=/usr/local/Cellar/node/12.12.0/bin/:$PATH

export FZF_DEFAULT_COMMAND="rg --files --hidden --color=never -g '!.git/**'"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias zshrc="nvim ~/dotfiles/.zshrc"
alias nvimrc="nvim ~/dotfiles/init.vim"
alias vim="nvim"
alias vi="nvim"
alias im="nvim"
alias webdis="cd ~/dev/webdis ; ./webdis & ; cd -"

listening() {
  if [ $# -eq 0 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P | grep $1
  fi
}

prompt_context() {
  # https://github.com/agnoster/agnoster-zsh-theme/issues/39#issuecomment-307338817
  if [[ "$USER" != "$LOGNAME" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
