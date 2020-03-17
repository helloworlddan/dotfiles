#!/bin/sh

export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
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
  FILE="$(mktemp)"
  gpg -s "${FILE}"
  rm -rf "${FILE}"
  rm -rf "${FILE}.gpg"
}

