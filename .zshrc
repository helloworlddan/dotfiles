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

safe_source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

function flush_dns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  sudo killall mDNSResponderHelper
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

function gpg_unlock(){
  touch gpg_unlock_payload
  gpg -e -r dan@hello-world.sh gpg_unlock_payload
  gpg gpg_unlock_payload.gpg
  rm -f gpg_unlock_payload gpg_unlock_payload.gpg
}

alias whaler="docker system prune -a"
alias vim="nvim"
alias render="note --no-editor"
alias nuke_sound="sudo kill `ps -ax | grep 'coreaudiod' | grep 'sbin' |awk '{print $1}'`"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export GPG_TTY="$(tty)"
export GPGKEY="9AECBF60B37C3708C1EC1FF1EDAC0E3FCB1B3FEB"
export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR="nvim"

defaults write -g ApplePressAndHoldEnabled -bool false

