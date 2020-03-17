#!/bin/sh

# Platform specifics
case "$(uname)" in
  "Darwin")
    export GOROOT="/usr/local/opt/go/libexec"
    export BASH_SILENCE_DEPRECATION_WARNING=1
    alias ls="ls -G"
    ;;
  "linux")
    alias ls="ls --color"
    ;;
  *)
    echo "unknow platform"
    ;;
esac

# Exports
export PS1="\[\e[35m\]\! \[\e[32m\]\$(git branch 2>/dev/null | grep '*' | colrm 1 2) \[\e[33m\]\w \[\e[m\]\$ "
export GOPATH="${HOME}/.go"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="/usr/local/sbin:$PATH"

beerfest(){
  brew upgrade
  brew cask upgrade --greedy
  brew cleanup -s --prune=0
  brew doctor
}

gpg_unlock(){
  file="$(mktemp)"
  gpg -s "${file}"
  rm -rf "${file}"
  rm -rf "${file}.gpg"
}

# Project specifics
source "${HOME}/.local/project.sh"
