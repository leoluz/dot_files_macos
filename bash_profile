#!/bin/bash

alias ll="ls -lG"
alias jekylls="jekyll serve --watch --baseurl ''"
alias starthttp="python -m SimpleHTTPServer 8080"
alias gm="git checkout master && git fetch origin && git rebase origin/master"
alias gr="git fetch origin && git rebase origin/master"
alias nopush="git remote set-url --push origin no_push"
eval "$(hub alias -s)"

# Kubernetes configs
alias k='kubectl'
alias kp="k get po --field-selector status.phase=Running"
# Enable bash complete for k alias
complete -o default -o nospace -F __start_kubectl k

source ~/dot_files_macos/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

GREEN='\[\e[32m\]'
BLUE='\[\e[34m\]'
YELLOW='\[\e[33m\]'
RED='\[\e[31m\]'
RESET_COLOR='\[\e[00m\]'
PS1="$BLUE[$GREEN\u $BLUE\W]$YELLOW"'$(__git_ps1)'"$BLUE \$$RESET_COLOR "

# System variables
export GOPATH="$HOME/dev/go"
export JAVA_HOME=$(/usr/libexec/java_home)
PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$HOME/dev/bin:$JAVA_HOME/bin:$GOPATH/bin:$PATH"

if [ -f ~/.ad_profile ]; then
    source ~/.ad_profile
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

