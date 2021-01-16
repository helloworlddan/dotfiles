#!/bin/sh

if [ -f "${HOME}/README-cloudshell.txt" ]; then
  rm "${HOME}/README-cloudshell.txt"
fi

# Exports
export PREPS1="$(date +%A | tr '[:upper:]' '[:lower:]')"
export PS1="\[\e[31m\]\${PREPS1} \[\e[34m\]\$(git branch 2>/dev/null | grep --color=never '*' | colrm 1 2) \[\e[92m\]\w \[\e[m\]\$ "
export GOPATH="${HOME}/.go"
export GPG_TTY=$(tty)
# Exports to extend PATH
export PATH="${GOROOT}/bin:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

# Aliases
alias gcurl='curl -H "$(gcloud auth application-default print-access-token)" -H "Content-Type: application/json" '
alias gproject='gcloud config get-value core/project'
alias ls="ls --color"
alias grep="grep --color=always"

