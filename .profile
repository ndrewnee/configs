# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$HOME/.local/bin:$PATH"

export GOROOT="/usr/local/go"
export GOPATH="$HOME/projects/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

export ANDROID_HOME="$HOME/programs/android-sdk-linux"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

alias connect_orders='ssh ndrew@178.218.207.79'
alias connect_mytaxi_test='ssh -i ~/amazon/new-mytaxi-test.pem ubuntu@54.72.185.137'
