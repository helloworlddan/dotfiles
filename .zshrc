#!/bin/zsh

source "${HOME}/Code/VWFS/mps-shell/mps-shell.sh"

function backup_file() {
  if [ -f ${1} ]
  then
    local SOURCE="$(basename ${1})"
    local TARGET="/tmp/bckp-${SOURCE}.$(date +%F).$$"
    echo "bckp: ${SOURCE} \t -> \t ${TARGET}"
    cp ${SOURCE} ${TARGET}
    return 0
  else
    logger -i -s -t "zshrc" -p user.err "error: couldn't backup file ${1}"
    return 1
  fi
}

function safe_source() {
  if [ -f ${1} ]
  then
    source ${1}
    return 0
  else
    logger -i -s -t "zshrc" -p user.err "error: couldn't source file ${1}"
    return 1
  fi
}

function flush_dns() {
  sudo killall -HUP mDNSResponder
  sudo killall mDNSResponderHelper
  sudo dscacheutil -flushcache
}

function tvm() {
  onetoken create stamer
  onetoken create cloudreach
  onetoken create vwfs
  onetoken refresh
  saml2aws-auto refresh vwfs

  SESSIONS="$(cat ~/.aws/credentials | grep -e '\[[a-zA-Z0-9\-]*-session\]$' | sort)"
  echo ""
  echo "${SESSIONS}" | column

  NUMSESS="$(echo "${SESSIONS}" | wc -l | grep -o -e '[^\s]*')"
  echo "\n${NUMSESS} hot sessions found."
}

function beerfest(){
  brew upgrade
  brew cask upgrade
  brew cleanup -s
  brew doctor
}

function cheat(){
  curl "cheat.sh/${1}"
}

alias whaler="docker system prune -a"
alias vim="nvim"
alias s2a="saml2aws-auto"
alias mutt="neomutt"
alias weather="curl wttr.in/Berlin"
alias sceptre="/usr/local/bin/sceptrefun"
alias render="note --no-editor"
alias nuke_sound="sudo kill `ps -ax | grep 'coreaudiod' | grep 'sbin' |awk '{print $1}'`"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export SCEPTRE_THEME="terran"
export AWS_HOME="${HOME}/.aws"
export AWS_DEFAULT_REGION="eu-central-1"
export AWS_DEFAULT_OUTPUT="json"
export ZSH="${HOME}/.oh-my-zsh"
export GPG_TTY="$(tty)"
export GPGKEY="9AECBF60B37C3708C1EC1FF1EDAC0E3FCB1B3FEB"
export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR="nvim"
export GOPATH="${HOME}/Code/Go"
export PATH="${HOME}.cargo/bin:${GOPATH}/bin:${PATH}"
export SSH_AUTH_SOCK="${HOME}/.ssh/ssh_auth_sock"
export WORKON_HOME="${HOME}/.virtualenvs"

ZSH_THEME="ys"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${HOME}/.zsh_history"

plugins=(
    git brew aws docker vagrant python
)

[ ! -S ~/.ssh/ssh_auth_sock ] && eval "$(ssh-agent)" && ln -sf "${SSH_AUTH_SOCK}" ~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

safe_source "${ZSH}/oh-my-zsh.sh"
safe_source "${HOME}/.fzf.zsh"

case "$(hostname -s)" in
  "skylake")
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    safe_source /usr/local/bin/virtualenvwrapper_lazy.sh
    safe_source "${HOME}/.bash-insulter/src/bash.command-not-found"
    default write -g ApplePressAndHoldEnabled -bool false
    ;;
  "nehalem")
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
    safe_source /usr/bin/virtualenvwrapper_lazy.sh
    ;;
  "*")
    logger -i -s -t "zshrc" -p user.warn "unknown host: $(hostname -s)"
    ;;
esac

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

