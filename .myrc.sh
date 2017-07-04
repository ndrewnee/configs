alias l='ls -G'
alias ll='ls -lGaf'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
export GOPATH=$HOME/Projects/go
export PATH="$GOPATH/bin/:/usr/local/Cellar/openvpn/2.4.1/sbin/:/usr/local/opt/go/libexec/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
export EDITOR=vim

# TODO Refator
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
