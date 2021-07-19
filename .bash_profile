#!/bin/sh

if [ -f "${HOME}/README-cloudshell.txt" ]; then
  rm "${HOME}/README-cloudshell.txt"
fi

# Exports
export PS1="\[\e[31m\]\$(date +%A | tr '[:upper:]' '[:lower:]') \[\e[34m\]\$(git branch 2>/dev/null | grep --color=never '*' | colrm 1 2) \[\e[92m\]\w \[\e[m\]\$ "
export GOPATH="${HOME}/.go"
export GPG_TTY=$(tty)
# Exports to extend PATH
export PATH="${GOROOT}/bin:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
# Exports for colored Man-Pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export EDITOR="vim"

# Aliases
alias gcurl='curl -H "$(gcloud auth application-default print-access-token)" -H "Content-Type: application/json" '
alias gproject='gcloud config get-value core/project'
alias ls="ls -hF --color=auto"
alias grep="grep --color=always"

# Shell Options
shopt -s histappend

