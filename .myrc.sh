# aliases
alias l='ls -G'
alias ll='ls -lGaf'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

# default editor
export EDITOR=vim

# general
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/Cellar/make/4.2.1_1/bin:$PATH"
# export PATH="/usr/local/Cellar/openvpn/2.4.1/sbin:$PATH"


# Node.js
export PATH="$HOME/.nvm/versions/node/v8.10.0/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# gvm - golang version manager
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOROOT_BOOTSTRAP=$(go env GOROOT)

# Golang
export GOPATH=$HOME/Projects/go
# export GOPATH=$HOME/.gvm/pkgsets/go1.13/global
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.gvm/gos/go1.13/bin/:$PATH"
# export GO111MODULE=on

# Rust
# export PATH="$HOME/.cargo/bin:$PATH"

# Ruby
# rbenv install
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# for russian coding in Wine
# export LC_COLLATE=ru_RU.UTF-8
# export LC_CTYPE=ru_RU.UTF-8

# git language
export LANG=en_US.UTF-8

# Python
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Haskell
# export PATH="$HOME/.local/bin:$PATH"

# Postgres
# export PATH="/usr/local/opt/postgresql@10/bin:$PATH"

# Flutter
# export PATH="$HOME/Projects/flutter/flutter/bin:$PATH"
