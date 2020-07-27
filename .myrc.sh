# aliases
alias l='ls -G'
alias ll='ls -lGaf'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
# alias stripe-cli='/usr/local/Cellar/stripe/1.3.4/bin/stripe'

# for russian coding in Wine
# export LC_COLLATE=ru_RU.UTF-8
# export LC_CTYPE=ru_RU.UTF-8

# git language
export LANG=en_US.UTF-8

# default editor
export EDITOR=vim

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# gvm - golang version manager
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOROOT_BOOTSTRAP=$(go env GOROOT)

# Golang
export GOPATH=$HOME/Projects/go
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

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
