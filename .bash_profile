#!/bin/sh

# Attach tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
      tmux attach -t default || tmux new -s default
fi

# Platform specifics
case "$(uname)" in
  "Darwin")
    export GOROOT="/usr/local/opt/go/libexec"
    export BASH_SILENCE_DEPRECATION_WARNING=1
    alias ls="ls -G"
    ;;
  "Linux")
    alias ls="ls --color"
    if [ -f "${HOME}/README-cloudshell.txt" ]; then
      rm "${HOME}/README-cloudshell.txt"
    fi
    ;;
  *)
    echo "unknown platform"
    ;;
esac

# Exports
export PREPS1="$(date +%A | tr '[:upper:]' '[:lower:]')"
export PS1="\[\e[31m\]\${PREPS1} \[\e[32m\]\$(git branch 2>/dev/null | grep '*' | colrm 1 2) \[\e[33m\]\w \[\e[m\]\$ "
export GOPATH="${HOME}/.go"
export PATH="${HOME}/.local/bin:${GOPATH}/bin:${GOROOT}/bin:/usr/local/sbin:${PATH}"
export GPG_TTY=$(tty)

# Additional functions
beerfest(){
  brew upgrade
  brew cask upgrade --greedy
  brew cleanup -s --prune=0
  brew doctor
}

# Aliases
alias gcurl='curl -H "$(gcloud auth application-default print-access-token)" -H "Content-Type: application/json" '
alias gproject='gcloud config get-value core/project'

# Project specifics
source "${HOME}/.local/project.sh"
