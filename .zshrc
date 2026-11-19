#
# Oh My ZSH
#

DEFAULT_USER=$USER
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666"

# ~/.oh-my-zsh/[custom]/plugins/
plugins=(
  git
  colored-man-pages
  colorize
  gh
  docker
  brew
  macos
)

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

#
# PATH
#

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/dev/scripts:$PATH
export PATH=/opt/homebrew/opt/postgresql@18/bin:$PATH
export PATH=$HOME/go/bin:$PATH

#
# Tools
#

# https://github.com/Schniz/fnm
eval "$(fnm env --use-on-cd)" # --version-file-strategy=recursive

# https://github.com/junegunn/fzf#setting-up-shell-integration
source <(fzf --zsh)

# https://worktrunk.dev/shell-integration/
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

#
# Environment
#

export EDITOR=nvim

[ -f ~/vars.sh ] && source ~/vars.sh

alias {vim,vi,im,vom}="nvim"
alias dotfiles="(cd ~/dotfiles && nvim)"
alias notes="(cd ~/Library/Mobile\\ Documents/iCloud\~md\~obsidian/Documents/Obsidian && nvim)"

alias assume="source assume"

alias python="python3"
alias pip="python3 -m pip"

#
# Utils
#

# checkout or create new branch
gch() {
  git checkout $1 2>/dev/null || git checkout -b $1;
}

# check what process is listening on :port
listening() {
  if [ $# -eq 0 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P
  elif [ $# -eq 1 ]; then
    lsof -iTCP -sTCP:LISTEN -n -P | grep $1
  fi
}

# decode JWT payload
jwtd() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

# time a network request
curl_time() {
    curl -so /dev/null -w "\
   namelookup: %{time_namelookup}s\n\
      connect: %{time_connect}s\n\
   appconnect: %{time_appconnect}s\n\
  pretransfer: %{time_pretransfer}s\n\
     redirect: %{time_redirect}s\n\
starttransfer: %{time_starttransfer}s\n\
-------------------------\n\
        total: %{time_total}s\n" "$@"
}

# get IP address
get_ip() {
  local ip="$(curl --silent ipinfo.io/ip)/32"
  printf '%s' "$ip" | pbcopy
  echo "$ip"
}
