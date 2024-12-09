#!/bin/sh

# Shell Options
shopt -s histappend

# Exports
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME="${HOME}/.config/"
export TERM=tmux-256color
export GPG_TTY=$(tty)
export EDITOR="nvim"
export GOPATH="${HOME}/.go"
export PATH="${GOPATH}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="/usr/games:${PATH}"
export PS1=" \[\e[1;35m\]\$(path_name) \[\e[0m\]\[\e[1;36m\]\$(branch_name) 
 \[\e[m\]\$ "
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
alias grep='grep --color=always'
alias noise='play -n synth brownnoise'
alias geoip='curl -s https://ipinfo.io/$(curl -s https://ipinfo.io/ip) | jq'
alias legit='git commit -asS'
alias ls="eza --icons"
alias la="ls -lah"
alias ll="ls -lh"
alias tree="ls --tree"
alias tls="tmux ls"
alias trename="tmux rename-window"
alias pdf='zathura'

alias gicurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'
alias gacurl='curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json"'
alias gawhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$(gcloud auth print-access-token)"'
alias giwhoami='curl "https://www.googleapis.com/oauth2/v1/tokeninfo?id_token=$(gcloud auth print-identity-token)"'

alias gnumber='echo $(gcloud projects describe $(gcloud config get-value core/project) --format "value(projectNumber)")'
alias gbuilds='gcloud builds list --limit 15 --format "table[box,title=\"Running Builds\"](createTime:sort=1,status,substitutions.REPO_NAME,substitutions.TRIGGER_NAME)"'
alias gbuildstream='gcloud builds log --stream $(gcloud builds list --ongoing --limit 1 --format "value(id)") 2>/dev/null || echo "no active builds"'
alias cross="/google/bin/releases/opensource/thirdparty/cross/cross"

# Functions
path_name() {
  pwd | sed -e "s:$HOME:~:" -e "s:\(.\)[^/]*/:\1/:g"
}

branch_name() {
  git branch 2>/dev/null | grep --color=never '*' | colrm 1 2
}

codewrap() {
  echo "\`\`\`"
  cat
  echo "\`\`\`"
}

textcopy() {
  xclip -selection clipboard
}

codecopy() {
  codewrap | textcopy
}

commit_info() {
  git show --quiet --show-signature HEAD | codewrap
  echo "remote reference: $(gh browse -c -n | sed 's/\/tree\//\/commit\//')"
}

commit_copy() {
  commit_info | textcopy
}

clone_all() {
  if [ -z ${1} ]; then
    echo "no gh owner supplied"
  else
    REPOS=$(gh repo list ${1} -L 500 --json name | jq -r '.[].name')
    echo "Found $(echo ${REPOS} | wc -w) repos in ${1}"
    for REPO in ${REPOS}; do
      if [ -d ${HOME}/Code/github.com/${1}/${REPO} ]; then
        echo "Pulling updates for ${REPO} from origin remote"
        (
          cd ${HOME}/Code/github.com/${1}/${REPO}
          git branch --set-upstream-to origin/main main
          git branch --set-upstream-to origin/master master
          git pull --all
        )
      else
        echo "Cloning ${REPO}"
        gh repo clone ${1}/${REPO} ${HOME}/Code/github.com/${1}/${REPO}
      fi
    done
  fi
}

encdir() {
  tar -cf - "${1%"/"}" | lz4 >"${1%"/"}.tar.lz4"
  gpg -er "dan@hello-world.sh" "${1%"/"}.tar.lz4"
  rm "${1%"/"}.tar.lz4"
}

decdir() {
  gpg "${1}"
  lz4 -cd ${1%".gpg"} | tar -xf -
  rm ${1%".gpg"}
}

nested() {
  startx -- /usr/bin/Xephyr -fullscreen -resizeable :2
}

terminal_session(){
  tsesh Terminal
}

editor_session(){
  tsesh Editor
}

tsesh() {
  if [ -z ${1} ]; then
    echo "no name given"
  else
  tmux attach-session -t ${1} || tmux new -s ${1}
  fi
}

twin() {
  if [ -z ${1} ]; then
    echo "no name given"
  else
    tmux new-window -n ${1} -c "#{pane_current_path}"
  fi
}

trepo() {
  if [ -z ${1} ]; then
    echo "no repo named"
  else
    tmux new-window -n ${1} -c ~/Code/github.com/${1}
  fi
}

deckdesk() {
  for monitor in bsh vim doc gcp add web com cal not gvc pers
  do
    sleep 2 && sh <(semnodes $monitor)
    sh <(semnodes -l $monitor)
  done

  sleep 2 && sh <(semnodes bsh)
  disown -a
  clear
}

# Cloud Functions
gmeta() {
  curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/${1}"
}

gmachine() {
  sudo dmidecode | grep -A9 '^System Information'
  printf "Machine Type \t "
  gmeta instance/machine-type
  printf "\nCPU Platform \t "
  gmeta instance/cpu-platform
  printf "\nLocation \t "
  gmeta instance/zone
  echo
}

guser() {
  if [ -z ${1} ]; then
    gcloud config get-value core/account
  else
    gcloud config set account ${1}
  fi
}

gproject() {
  if [ -z ${1} ]; then
    gcloud config get-value core/project
  else
    gcloud config set project ${1}
  fi
}

gregion() {
  if [ -z ${1} ]; then
    gcloud config get-value run/region
  else
    gcloud config set run/region ${1}
    gcloud config set functions/region ${1}
    gcloud config set deploy/region ${1}
    gcloud config set compute/region ${1}
    gcloud config set compute/zone ${1}-a
    gcloud config set artifacts/location ${1}
    gcloud config set eventarc/location ${1}
    gcloud config set memcache/region ${1}
    gcloud config set redis/region ${1}
  fi
}

grunlogs() {
  gcloud logging read \
    --format "value(textPayload)" \
    --limit 40 \
    "resource.type = \"cloud_run_revision\" resource.labels.service_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null " | tac
}

grunjlogs() {
  gcloud logging read \
    --format "value(textPayload)" \
    --limit 40 \
    "resource.type = \"cloud_run_job\" resource.labels.job_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null " | tac
}

grunlogstream() {
  export CLOUDSDK_PYTHON_SITEPACKAGES=1
  gcloud alpha logging tail \
    --format "value(textPayload)" \
    "resource.type = \"cloud_run_revision\" resource.labels.service_name = \"$1\" resource.labels.location = \"$(gcloud config get-value run/region)\" textPayload != null "
}

gkilldrs() {
  gcloud org-policies reset constraints/iam.allowedPolicyMemberDomains \
    --project $(gcloud config get-value project)
}

gkillbinauthz() {
  gcloud org-policies reset constraints/run.allowedBinaryAuthorizationPolicies \
    --project $(gcloud config get-value project)
}

user_name() {
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

# Collider Functions
gizmo() {
  GIZMO_MESSAGE=$(cat)
  curl \
    -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
    -H "Content-Type: application/json" \
    --data "{\"text\": \"${GIZMO_MESSAGE}\"}" \
    https://gizmo.collider.hello-world.sh/post
}

snippet() {
  SNIPPET_MESSAGE=$(cat)
  curl \
    -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
    -H "Content-Type: application/json" \
    --data "{\"author\": \"stamer@google.com\", \"type\": \"CHAT\", \"time\": \"$(date -Iseconds)\", \"text\": \"${SNIPPET_MESSAGE}\"}" \
    https://snippet.collider.hello-world.sh/
}

# Source local overrides, if available
if [ -f "${HOME}/.bash_profile.local" ]; then
  source "${HOME}/.bash_profile.local"
fi

# Initializers
test -r ${HOME}/.opam/opam-init/init.sh && . ${HOME}/.opam/opam-init/init.sh >/dev/null 2>/dev/null || true
test -r opam && eval $(opam env)
test -r ${HOME}/.ghcup/env && source ${HOME}/.ghcup/env
test -r collider && source <(collider completion bash)

# MOTD
test -x tortune && tortune
