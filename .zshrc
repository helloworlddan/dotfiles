#!/bin/zsh

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

function asp(){
  export AWS_DEFAULT_PROFILE="${1}"
}

function aup(){
  unset AWS_DEFAULT_PROFILE
}

function flush_dns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  sudo killall mDNSResponderHelper
}

function tvm() {
  aup
  aws-mfa --profile stamer
  aws-mfa --profile cloudreach
  saml2aws-auto refresh vwfs

  SESSIONS="$(cat ~/.aws/credentials | grep -e '\[[a-zA-Z0-9\-]*\]$' | sort)"
  echo ""
  echo "${SESSIONS}" | column

  NUMSESS="$(echo "${SESSIONS}" | wc -l | grep -o -e '[^\s]*')"
  echo "\n${NUMSESS} hot sessions found."
}

function beerfest(){
  brew upgrade
  brew cask upgrade
  brew cleanup -s --prune=0
  brew doctor
}

function beerbinge(){
  brew upgrade
  brew cask upgrade --greedy
  brew cleanup -s --prune=0
  brew doctor
}

alias whaler="docker system prune -a"
alias vim="nvim"
alias s2a="saml2aws-auto"
alias render="note --no-editor"
alias nuke_sound="sudo kill `ps -ax | grep 'coreaudiod' | grep 'sbin' |awk '{print $1}'`"

safe_source "${HOME}/Code/VWFS/mps-shell/mps-shell.sh"
safe_source "${HOME}/.rvm/scripts/rvm"
safe_source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export AWS_HOME="${HOME}/.aws"
export AWS_DEFAULT_REGION="eu-central-1"
export AWS_DEFAULT_PROFILE="default"
export AWS_DEFAULT_OUTPUT="json"
export GPG_TTY="$(tty)"
export GPGKEY="9AECBF60B37C3708C1EC1FF1EDAC0E3FCB1B3FEB"
export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR="nvim"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/Code/Go/bin"
export PATH="$PATH:$HOME/Library/Python/3.7/bin"
export PATH="$PATH:$HOME/.bin"

defaults write -g ApplePressAndHoldEnabled -bool false

