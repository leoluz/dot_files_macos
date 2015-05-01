#!/bin/bash

alias ll="ls -lG"
alias jekylls="jekyll serve --watch --baseurl ''"
source ~/dot_files_macos/git-prompt.sh
GREEN='\e[01;32m'
BLUE='\e[01;34m'
YELLOW='\e[01;33m'
RED='\e[01;31m'
RESET_COLOR='\e[00m'
PS1="$BLUE[$GREEN\u $BLUE\W]$YELLOW"'$(__git_ps1)'"$BLUE\$$RESET_COLOR "
GIT_PS1_SHOWDIRTYSTATE=1

# Hybris variables
#export YAAS_GROOVY_CONFIG_FILE="$HOME/dev/groovy/groovyCommonsConfig.groovy"
#export CAAS_ENVIRONMENT="development"

# System variables
export GOROOT="/usr/local/go"
export GOPATH="$HOME/dev/go"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$GOPATH/bin:$GOROOT/bin:$JAVA_HOME/bin:/usr/local/bin:$PATH"

#eval "$(rbenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/i839864/.gvm/bin/gvm-init.sh" ]] && source "/Users/i839864/.gvm/bin/gvm-init.sh"
