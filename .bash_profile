#!/bin/sh

if [ -f "${HOME}/README-cloudshell.txt" ]; then
  rm "${HOME}/README-cloudshell.txt"
fi

# Functions
clock() {
    TZ="Europe/Berlin" date +"%H%M"
}
project_name() {
    cat ~/.config/gcloud/configurations/config_default | grep -oP "^project = \K.*"
}
branch_name() {
    git branch 2>/dev/null | grep --color=never '*' | colrm 1 2
}
path_name() {
    if [ $HOME == $PWD ];
    then
       echo "~" && exit 0
    fi
    echo "$(pwd | sed -e "s/\/home\/${USER}/~/g" | sed -r 's|/(.)[^/]*|/\1|g' | sed -E 's/.?$//g')$(basename ${PWD})"
}

# Exports
export PS1="\[\e[34m\]\$(clock) \[\e[31m\]\$(project_name) \[\e[33m\]\$(branch_name) \[\e[92m\]\$(path_name) \[\e[m\]\$ "
#export GOPATH="${HOME}/.go"
export GPG_TTY=$(tty)
export EDITOR="vim"
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
alias gbuilds='gcloud builds list --limit 10 --format "table[box,title=\"Running Builds\"](createTime:sort=1,status,substitutions.REPO_NAME,substitutions.BRANCH_NAME,substitutions.TRIGGER_NAME)"'
alias gbuildstream='gcloud builds log --stream $(gcloud builds list --ongoing --limit 1 --format "value(id)") || echo "no active builds"'
alias gwhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'
alias ls="ls -hF --color=auto"
alias grep="grep --color=always"

# Shell Options
shopt -s histappend