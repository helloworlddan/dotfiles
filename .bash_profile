#!/bin/sh

if [ -f "${HOME}/README-cloudshell.txt" ]; then
  rm "${HOME}/README-cloudshell.txt"
fi

# Exports
export PS1="\[\e[31m\]\$(date +%A | tr '[:upper:]' '[:lower:]') \[\e[34m\]\$(git branch 2>/dev/null | grep --color=never '*' | colrm 1 2) \[\e[92m\]\w \[\e[m\]\$ "
export GOPATH="${HOME}/.go"
export GPG_TTY=$(tty)
export EDITOR="vim"
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

# Aliases
alias gcurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'
alias gproject='gcloud config get-value core/project'
alias gnumber='$(gcloud projects describe $(gcloud config get-value core/project) --format "value(projectNumber)")'
alias gbuildstream='gcloud builds log --stream $(gcloud builds list --ongoing --limit 1 --format "value(id)") || echo "no active builds"'
alias gwhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'
alias ls="ls -hF --color=auto"
alias grep="grep --color=always"

# Shell Options
shopt -s histappend


cat << EOF
Hey Dan!

Hows things? I hope you're good.
You know I've been trying to get hold of you.. Did you drop off the face of the earth!??

I'm coming to Berlin for a few weeks in October, I was wondering if you'd be up for a beer or something?

Don't let your wingman down!

Mav
EOF

