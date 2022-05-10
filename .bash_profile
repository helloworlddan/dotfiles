#!/bin/sh

if [ -f "${HOME}/README-cloudshell.txt" ]; then
  rm "${HOME}/README-cloudshell.txt"
fi

# Functions
branch_name() {
    git branch 2>/dev/null | grep --color=never '*' | colrm 1 2
}
path_name() {
  pwd | sed -e "s:$HOME:~:" -e "s:\(.\)[^/]*/:\1/:g"
}

# Exports
export GPG_TTY=$(tty)
export EDITOR="vim"
export GOPATH="${HOME}/.go"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export GOPATH="${HOME}/.go/"
export PS1="\[\e[33m\]\$(branch_name) \[\e[92m\]\$(path_name) \[\e[m\]\$ "
# Exports for colored Man-Pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# Aliases
alias ls='ls -hF --color=auto'
alias grep='grep --color=always'
alias tree='tree -C'
alias vpnro='sudo openvpn /etc/openvpn/ro/client.conf'
alias vpnes='sudo openvpn /etc/openvpn/es/client.conf'
alias geoip='curl -s https://ipinfo.io/$(curl -s https://ipinfo.io/ip) | jq'
alias gicurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'
alias gacurl='curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json"'
alias gproject='gcloud config get-value core/project'
alias gnumber='echo $(gcloud projects describe $(gcloud config get-value core/project) --format "value(projectNumber)")'
alias gbuilds='gcloud builds list --limit 10 --format "table[box,title=\"Running Builds\"](createTime:sort=1,status,substitutions.REPO_NAME,substitutions.BRANCH_NAME,substitutions.TRIGGER_NAME)"'
alias gbuildstream='gcloud builds log --stream $(gcloud builds list --ongoing --limit 1 --format "value(id)") 2>/dev/null || echo "no active builds"'
alias gwhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'

# Functions
grunlogs () {
  gcloud logging read \
    --format "value(textPayload)" \
    --limit 20 \
    "resource.type = \"cloud_run_revision\" resource.labels.service_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null severity>=DEFAULT logName = \"projects/$(gcloud config get-value project)/logs/run.googleapis.com%2Fstderr\"" | tac
}

grunlogstream () {
  export CLOUDSDK_PYTHON_SITEPACKAGES=1
  gcloud alpha logging tail \
    --format "value(textPayload)" \
    "resource.type = \"cloud_run_revision\" resource.labels.service_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null severity>=DEFAULT logName = \"projects/$(gcloud config get-value project)/logs/run.googleapis.com%2Fstderr\""
}

# Shell Options
shopt -s histappend

# Source local overrides, if available
if [ -f "${HOME}/.bash_profile.local" ]; then
  source "${HOME}/.bash_profile.local"
fi

