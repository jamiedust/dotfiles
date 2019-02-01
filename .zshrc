# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jamie.woolgar/.oh-my-zsh

ZSH_THEME=agnoster

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git colored-man colorize github docker brew osx zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/set_env.sh"

PATH=$HOME/bin:/usr/local/bin:~/.fastlane/bin:~/.nvm/:~/Library/Android/sdk:~/Library/Android/sdk/tools:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/platform-tools/adb:~/samsung-tv-sdk:~/tizen-sdk/tools/ide/bin:~/samsung-tv-sdk/tools/ide/bin/tizen:~/webOS_TV_SDK/CLI/bin$PATH

alias zshrc="nvim ~/dotfiles/.zshrc"
alias nvimrc="nvim ~/dotfiles/init.vim"
alias vim="nvim"
alias vi="nvim"

export FZF_DEFAULT_COMMAND="rg --files --color=never"

# NVM

export NVM_DIR="/Users/jamie.woolgar/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use --delete-prefix default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
