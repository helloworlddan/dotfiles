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
chrome_app(){
  google-chrome --app="https://${1}" || google-chrome-stable --app="https://${1}"
}
playing_song(){
  spotify s 2>&1 1>/dev/null | head -n 1 | tr -d '[:cntrl:]' | tr -cd '[:print:]ÄäÖöÜü' | tail -c +4 && echo
}
playing_artist(){
  spotify s 2>&1 1>/dev/null | head -n 2 | tail -n 1 | tr -d '[:cntrl:]' | tr -cd '[:print:]ÄäÖöÜü' | tail -c +4 && echo
}
ssh_key_add(){
  unset CHROME_REMOTE_DESKTOP_SESSION
  eval $(ssh-agent -s)
  ssh-add
}
goto(){
  target=$1
  [[ $target != go/* ]] && target="go/${target}"
  google-chrome --app="http://${target}" || google-chrome-stable --app="http://${target}"
}

# Exports
export GPG_TTY=$(tty)
export EDITOR="vim"
export GOPATH="${HOME}/.go"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="/usr/games:${PATH}"
export PATH="${GOPATH}/bin:${PATH}"
export GOPATH="${HOME}/.go/"
export PS1="\[\e[0m\] \[\e[33m\]\$(user_name)\[\e[0m\] @ \[\e[32m\]\$(user_domain)\[\e[0m\] -> \[\e[31m\]\$(project_name)\[\e[0m\] : \[\e[34m\]\$(run_region)
 \[\e[36m\]\$(path_name) \[\e[0m\]\[\e[35m\]\$(branch_name) \[\e[m\]\$ "
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
alias noise='play -n synth brownnoise'
alias geoip='curl -s https://ipinfo.io/$(curl -s https://ipinfo.io/ip) | jq'
alias gicurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'
alias gacurl='curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json"'
alias gproject='gcloud config get-value core/project'
alias gnumber='echo $(gcloud projects describe $(gcloud config get-value core/project) --format "value(projectNumber)")'
alias gbuilds='gcloud builds list --limit 10 --format "table[box,title=\"Running Builds\"](createTime:sort=1,status,substitutions.REPO_NAME,substitutions.BRANCH_NAME,substitutions.TRIGGER_NAME)"'
alias gbuildstream='gcloud builds log --stream $(gcloud builds list --ongoing --limit 1 --format "value(id)") 2>/dev/null || echo "no active builds"'
alias gawhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'
alias giwhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?id_token=$(gcloud auth print-identity-token)"'
alias legit='git commit -asS'

# Cloud Functions
gmeta () {
  curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/${1}"
}
gregion () {
  gcloud config set run/region ${1}
  gcloud config set deploy/region ${1}
  gcloud config set compute/region ${1}
  gcloud config set artifacts/location ${1}
}
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

tortune

