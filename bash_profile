#!/bin/bash

alias ll="ls -lG"
source ~/dot_files_macos/git-prompt.sh
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
GIT_PS1_SHOWDIRTYSTATE=1

export CAAS_ENVIRONMENT="development"
export GOROOT="/usr/local/go"
export GOPATH="$HOME/dev/go"
export PATH="/usr/local/bin:$GOPATH/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/leoluz/.gvm/bin/gvm-init.sh" ]] && source "/Users/leoluz/.gvm/bin/gvm-init.sh"
