#!/bin/zsh

function backup_file() {
  if [ -f ${1} ]
  then
    local SOURCE=$(basename ${1})
    local TARGET="/tmp/bckp-${SOURCE}.$(date +%F).$$"
    echo "bckp: ${SOURCE} \t -> \t ${TARGET}"
    cp ${SOURCE} ${TARGET}
    return 0
  else
    echo "error: couldn't backup file ${1}"
    return 1
  fi
}

function safe_source() {
  if [ -f ${1} ]
  then
    source ${1}
    return 0
  else
    echo "error: couldn't source file ${1}"
    return 1
  fi
}

alias vim=nvim
alias mutt=neomutt
alias weather="curl wttr.in/Berlin"

export ZSH=~/.oh-my-zsh
export GPG_TTY=$(tty)
export GPGKEY=9AECBF60B37C3708C1EC1FF1EDAC0E3FCB1B3FEB
export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR=nvim
export GOPATH="$HOME/Code/Go"
export PATH="$HOME.cargo/bin:$GOPATH/bin:$PATH"
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
export WORKON_HOME=~/.virtualenvs

ZSH_THEME="mh"
ZSH_THEME="ys"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

bindkey "[D" backward-word
bindkey "[C" forward-word

plugins=(
    git brew aws docker vagrant python
)

[ ! -S ~/.ssh/ssh_auth_sock ] && eval `ssh-agent` && ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

safe_source $HOME/.bash-insulter/src/bash.command-not-found
safe_source $ZSH/oh-my-zsh.sh
safe_source ~/.fzf.zsh

case "$(hostname -s)" in
  "skylake")
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    safe_source /usr/local/bin/virtualenvwrapper_lazy.sh
    ;;
  "nehalem")
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
    safe_source /usr/bin/virtualenvwrapper_lazy.sh
    ;;
esac

echo "\n $(fortune)"
