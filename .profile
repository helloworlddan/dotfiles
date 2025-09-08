#!/bin/sh

if [ -e "${HOME}/.shrc" ]; then
  export ENV="${HOME}/.shrc"
  export BASH_ENV="${HOME}/.shrc"
  source "${HOME}/.shrc"
fi
