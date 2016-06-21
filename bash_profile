#!/bin/bash

alias ll="ls -lG"
alias jekylls="jekyll serve --watch --baseurl ''"
alias starthttp="python -m SimpleHTTPServer 8080"
alias vpn-batman="sudo openconnect --authgroup=Employee --user=leo.almeida batman.appdirect.com"
alias vpn-iceman="sudo openconnect --authgroup=Employee --user=leo.almeida iceman.appdirect.com"

source ~/dot_files_macos/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

GREEN='\[\e[01;32m\]'
BLUE='\[\e[01;34m\]'
YELLOW='\[\e[01;33m\]'
RED='\[\e[01;31m\]'
RESET_COLOR='\[\e[00m\]'
PS1="$BLUE[$GREEN\u $BLUE\W]$YELLOW"'$(__git_ps1)'"$BLUE \$$RESET_COLOR "

# System variables
export GOROOT="/usr/local/go"
export GOPATH="$HOME/dev/go"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$GOPATH/bin:$GOROOT/bin:$JAVA_HOME/bin:/usr/local/bin:$HOME/dev/bin:$PATH"
export MAVEN_DEBUG_OPTS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"
export MAVEN_OPTS="-Xms1024m -Xmx2048m -noverify -XX:MaxMetaspaceSize=760m"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/leoluz/.sdkman"
[[ -s "/Users/leoluz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/leoluz/.sdkman/bin/sdkman-init.sh"
