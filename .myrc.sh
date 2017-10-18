# aliases
alias l='ls -G'
alias ll='ls -lGaf'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias typora="open -a typora"

# golang
export GOPATH=$HOME/Projects/go
export PATH="/usr/local/Cellar/make/4.2.1_1/bin:$PATH"
export PATH="$GOPATH/bin/:/usr/local/Cellar/openvpn/2.4.1/sbin/:/usr/local/opt/go/libexec/bin:$PATH"
# for nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
# default editor
export EDITOR=vim

# rbenv install
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# for russian coding in Wine
export LC_COLLATE=ru_RU.UTF-8
export LC_CTYPE=ru_RU.UTF-8

# telegram binary
export PATH="/Users/ndrewnee/Projects/tg/bin:$PATH"

# find and replace in terminal
function replace {
    if [ $# -ne 2 ]
      then
        echo "Usage: replace <find> <replace>"
        return
    fi

    from="$1"
    to="$2"

    ack -l ''$from'' | xargs perl -pi -E 's/'$from'/'$to'/g'
}
