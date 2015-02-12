#!/bin/bash

alias ll="ls -lG"
alias jekylls="jekyll serve --watch --baseurl ''"
source ~/dot_files_macos/git-prompt.sh
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
GIT_PS1_SHOWDIRTYSTATE=1

# Hybris variables
export YAAS_GROOVY_CONFIG_FILE="$HOME/dev/groovy/groovyCommonsConfig.groovy"

# System variables
export GOROOT="/usr/local/go"
export GOPATH="$HOME/dev/go"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$GOPATH/bin:/usr/local/bin:$PATH"

eval "$(rbenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/leoluz/.gvm/bin/gvm-init.sh" ]] && source "/Users/leoluz/.gvm/bin/gvm-init.sh"
