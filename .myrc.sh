# aliases
alias l='ls -G'
alias ll='ls -lGaf'
alias vim=nvim

export LANG=en_US.UTF-8
export EDITOR=vim
export PATH="/opt/homebrew/bin:$PATH"

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# PostreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Load private settings
# source ~/.private.sh

# Golang
# gvm - golang version manager
#
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
#
# export GOROOT_BOOTSTRAP=$(go env GOROOT)
# export GOPATH=$HOME/Projects/go
# export PATH="$GOPATH/bin:$PATH"
# export GO111MODULE=on

# Rust
# export PATH="$HOME/.cargo/bin:$PATH"

# Ruby
# rbenv install
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# Python
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Haskell
# export PATH="$HOME/.local/bin:$PATH"

# For russian coding in Wine
# export LC_COLLATE=ru_RU.UTF-8
# export LC_CTYPE=ru_RU.UTF-8

