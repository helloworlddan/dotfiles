#!/bin/sh

if [ -e "${HOME}/.shrc" ]; then
  export ENV="${HOME}/.shrc"
  export BASH_ENV="${HOME}/.shrc"
  . "${HOME}/.shrc"
fi
