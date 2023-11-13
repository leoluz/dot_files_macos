export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$JAVA_HOME/bin:$GOPATH/bin:$DOT_FILES_HOME/bin:$PATH"
export DOT_FILES_HOME="$HOME/dot_files_macos"
export GOPATH="$HOME/dev/go"
export JAVA_HOME=$(/usr/libexec/java_home)
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export GPG_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"
# [ -f $HOME/.ad_profile ] && source $HOME/.ad_profile
# [ -f $HOME/.dw_profile ] && source $HOME/.dw_profile
# [ -f $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm
# [ -d $HOME/.krew/bin ] && export PATH="${HOME}/.krew/bin:${PATH}"
# [ -d $HOME/dev/nvim-osx64 ] && export PATH="${HOME}/dev/nvim-osx64/bin:${PATH}"
# [ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
# [ -d $HOME/bin/google-cloud-sdk/bin ] && export PATH="${HOME}/bin/google-cloud-sdk/bin:${PATH}"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# [ -d $HOME/bin/codeql ] && export PATH="$HOME/bin/codeql:${PATH}"
[ -f $HOME/.it_profile ] && source $HOME/.it_profile
[ -d $HOME/dev/bin ] && export PATH="${HOME}/dev/bin:${PATH}"
[ -d $GOPATH/bin ] && export PATH="${GOPATH}/bin:${PATH}"
type nvim >/dev/null 2>&1 && export EDITOR="nvim"

ZSH_CUSTOM="$HOME/dot_files_macos/zsh-custom"
# PROMPT='$(kube_ps1)'$PROMPT
RPROMPT='$(kube_ps1)'

# gm will checkout the upstream ('origin' if 'upstream' is not available) HEAD branch, fetch remote and rebase
function gm() {
    if [[ $(git remote) =~ "upstream$" ]]; then
        REMOTE=upstream
    else
        REMOTE=origin
    fi
    MAIN=$(git remote show $REMOTE | awk '/HEAD branch/ {print $NF}')
    git checkout $MAIN
    git fetch $REMOTE
    git rebase $REMOTE/$MAIN
}
#
# gr will fetch the upstream HEAD branch rebase
function gr() {
    if [[ $(git remote) =~ "upstream$" ]]; then
        REMOTE=upstream
    else
        REMOTE=origin
    fi
    MAIN=$(git remote show $REMOTE | awk '/HEAD branch/ {print $NF}')
    git fetch $REMOTE
    git rebase $REMOTE/$MAIN
}

unalias gm
unalias gr
# alias swagger="docker run --rm -it -e GOPATH=$GOPATH:/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"
#
capture_osx() {
    sudo dtrace -p "$1" -qn '
        syscall::write*:entry
        /pid == $target && arg0 == 1/ {
            printf("%s", copyinstr(arg1, arg2));
        }
    '
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# alias luamake=/Users/lalmeida1/dev/git/lua-language-server/3rd/luamake/luamake

# get ArgoCD controller pid
alias cpid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep repo-server | grep -v dex-server | awk '{print \$2}'"
# get ArgoCD repo pid
alias rpid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep -v dex-server | grep '\-\-port' | awk '{print \$2}'"
# get ArgoCD CMP pid
alias ppid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep config-dir-path | awk '{print \$2}'"
# get ArgoCD API server pid
alias apid="ps aux | grep dist/argocd | grep -v BIN_MODE | grep '\-\-disable-auth' | awk '{print \$2}'"

type fastfetch >/dev/null 2>&1 && fastfetch
