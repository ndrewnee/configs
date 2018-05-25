# aliases
alias l='ls -G'
alias ll='ls -lGaf'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
# default editor
export EDITOR=vim

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# gvm - golang version manager
[[ -s "/Users/ndrewnee/.gvm/scripts/gvm" ]] && source "/Users/ndrewnee/.gvm/scripts/gvm"
export GOROOT_BOOTSTRAP=$(go env GOROOT)

export GOPATH=$HOME/Projects/go

export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/go/libexec/bin:$PATH"
# export PATH="/usr/local/Cellar/openvpn/2.4.1/sbin:$PATH"
export PATH="/usr/local/Cellar/make/4.2.1_1/bin:$PATH"
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# for nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# rbenv install
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# for russian coding in Wine
export LC_COLLATE=ru_RU.UTF-8
export LC_CTYPE=ru_RU.UTF-8
