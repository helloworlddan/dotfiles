#!/bin/sh

# Shell Options
shopt -s histappend

# Exports
export GPG_TTY=$(tty)
export EDITOR="nvim"
export GOPATH="${HOME}/.go"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="/usr/games:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export GOPATH="${HOME}/.go/"
export PS1=" \[\e[1;36m\]\u \[\e[0m\]@ \[\e[1;35m\]\H
 \[\e[1;33m\]\$(path_name) \[\e[0m\]\[\e[1;34m\]\$(branch_name) \[\e[m\]\$ "
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# Aliases
alias vim='nvim'
alias vimdiff='nvim -d'
alias ls='ls -hF --color=auto'
alias grep='grep --color=always'
alias tree='tree -C'
alias noise='play -n synth brownnoise'
alias geoip='curl -s https://ipinfo.io/$(curl -s https://ipinfo.io/ip) | jq'
alias legit='git commit -asS'

alias gicurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'
alias gacurl='curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json"'
alias gawhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'
alias giwhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?id_token=$(gcloud auth print-identity-token)"'

alias gnumber='echo $(gcloud projects describe $(gcloud config get-value core/project) --format "value(projectNumber)")'
alias gbuilds='gcloud builds list --limit 10 --format "table[box,title=\"Running Builds\"](createTime:sort=1,status,substitutions.REPO_NAME,substitutions.BRANCH_NAME,substitutions.TRIGGER_NAME)"'
alias gbuildstream='gcloud builds log --stream $(gcloud builds list --ongoing --limit 1 --format "value(id)") 2>/dev/null || echo "no active builds"'
alias balm='~/.go/bin/balm -g butthole-of-the-internet'
alias batcomputer=" balm -p 'you are the bat computer, i am batman. call me master wayne.' -"

# Functions
branch_name() {
  git branch 2>/dev/null | grep --color=never '*' | colrm 1 2
}

commit_info(){
  echo "\`\`\`"
  git show --quiet --show-signature HEAD
  echo "\`\`\`"
  echo "remote reference: $(gh browse -c -n | sed 's/\/tree\//\/commit\//')"
}

path_name() {
  pwd | sed -e "s:$HOME:~:" -e "s:\(.\)[^/]*/:\1/:g"
}

commit_copy(){
  commit_info | xclip -selection clipboard
}

encdir() {
 tar -cf - "${1%"/"}" | lz4 > "${1%"/"}.tar.lz4"   
 gpg -er "dan@hello-world.sh" "${1%"/"}.tar.lz4" 
 rm "${1%"/"}.tar.lz4"
}

decdir() {
 gpg "${1}" 
 lz4 -cd ${1%".gpg"} | tar -xf -
 rm ${1%".gpg"}
}

nested(){
  startx -- /usr/bin/Xephyr -fullscreen -resizeable :2
}

deckdesk () {
  sleep 2 && bspc desktop -f '^11'
  goto -p 1 &
  sleep 2 && bspc desktop -f '^4'
  goto -p 2 &
  sleep 2 && bspc desktop -f '^21'
  goto -p 3 &

  sleep 2 && bspc desktop -f '^3'
  goto -p 1 -u cloud.google.com/go/docs/reference/cloud.google.com/go/latest &
  sleep 2 && bspc desktop -f '^3'
  goto -p 1 -u pkg.go.dev &
  sleep 2 && bspc desktop -f '^5'
  goto -p 1 companion &

  sleep 2 && bspc desktop -f '^12'
  goto -p 1 -g mail &
  sleep 2 && bspc desktop -f '^13'
  goto -p 1 -g calendar &
  sleep 2 && bspc desktop -f '^14'
  goto -p 1 -u drive.google.com/scary/drive/recent &
  sleep 2 && bspc desktop -f '^15'
  goto -p 1 companion &

  sleep 2 && bspc desktop -f '^16'
  goto -p 1 dn-workspace &
  sleep 2 && bspc desktop -f '^17'
  goto -p 1 pxl &
  sleep 2 && bspc desktop -f '^18'
  goto -p 1 nucleus:lac &
  sleep 2 && bspc desktop -f '^20'
  goto -p 1 eat &

  sleep 2 && bspc desktop -f '^2'
  xterm &
  sleep 2 && bspc desktop -f '^1'

  disown -a
  clear
}

# Cloud Functions
gmeta () {
  curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/${1}"
}

guser () {
  if [ -z ${1} ]
  then
    gcloud config get-value core/account
  else
    gcloud config set account ${1}
  fi
}

gproject () {
  if [ -z ${1} ]
  then
    gcloud config get-value core/project
  else
    gcloud config set project ${1}
  fi
}

gregion () {
  if [ -z ${1} ]
  then
    gcloud config get-value run/region
  else
    gcloud config set run/region ${1}
    gcloud config set functions/region ${1}
    gcloud config set deploy/region ${1}
    gcloud config set compute/region ${1}
    gcloud config set compute/zone ${1}-a
    gcloud config set artifacts/location ${1}
    gcloud config set memcache/region ${1}
    gcloud config set redis/region ${1}
  fi
}

grunlogs () {
  gcloud logging read \
    --format "value(textPayload)" \
    --limit 40 \
    "resource.type = \"cloud_run_revision\" resource.labels.service_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null " | tac
}

grunjlogs () {
  gcloud logging read \
    --format "value(textPayload)" \
    --limit 40 \
    "resource.type = \"cloud_run_job\" resource.labels.job_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null " | tac
}

grunlogstream () {
  export CLOUDSDK_PYTHON_SITEPACKAGES=1
  gcloud alpha logging tail \
    --format "value(textPayload)" \
    "resource.type = \"cloud_run_revision\" resource.labels.service_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null "
}

gkilldrs(){
  gcloud org-policies reset constraints/iam.allowedPolicyMemberDomains \
    --project $(gcloud config get-value project)
}
gkillbinauthz(){
  gcloud org-policies reset constraints/run.allowedBinaryAuthorizationPolicies \
    --project $(gcloud config get-value project)
}

user_name (){
  cat ~/.config/gcloud/configurations/config_default 2>/dev/null | grep -Po '^account = \K(\w+)'
}

user_domain() {
  cat ~/.config/gcloud/configurations/config_default 2>/dev/null | grep -Po '^account = \w+@\K(.+)$'
}

project_name() {
  cat ~/.config/gcloud/configurations/config_default 2>/dev/null | grep -Po '^project = \K(.*)$'
}

run_region() {
  cat ~/.config/gcloud/configurations/config_default 2>/dev/null | grep -Pom 1 '^region = \K(.*)$'
} 

gizmo () {
  GIZMO_MESSAGE=$(cat)
  curl \
    -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
    -H "Content-Type: application/json" \
    --data "{\"text\": \"${GIZMO_MESSAGE}\"}" \
    https://gizmo.collider.nucleus-engineering.cloud/post
  }

snippet () {
  SNIPPET_MESSAGE=$(cat)
  curl \
    -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
    -H "Content-Type: application/json" \
    --data "{\"author\": \"stamer@google.com\", \"type\": \"CHAT\", \"time\": \"$(date -Iseconds)\", \"text\": \"${SNIPPET_MESSAGE}\"}" \
    https://snippet.collider.nucleus-engineering.cloud/
  }

# Source local overrides, if available
if [ -f "${HOME}/.bash_profile.local" ]; then
  source "${HOME}/.bash_profile.local"
fi

tortune

