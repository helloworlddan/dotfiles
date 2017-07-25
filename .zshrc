# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Power up SSH agent and add keys
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

prompt "paradox"

export PINENTRY_USER_DATA="USE_CURSES=1"
export EDITOR=vim
export GOPATH="$HOME/Development/Go"
export PATH="$GOPATH/bin:$PATH"


weather(){
    curl wttr.in/Berlin
}

n() {
    $EDITOR ~/Notes/"$*"
}

nls() {
    ls -c ~/Notes/ | grep "$*"
}

gitup() {
    for d in */ ; do
        cd  $d
        git pull --all
        cd ..
    done
}

pass () {
    cd ~/Documents/Passwords
    rm -f pass.yaml.gpg.back
    cp pass.yaml.gpg pass.yaml.gpg.back
    gpg -d pass.yaml.gpg > pass.yaml
    vim pass.yaml
    rm -f pass.yaml.gpg
    gpg -e -r daniel@stamer.info pass.yaml
    rm -f pass.yaml
    cd ~
}

lan() {
    sudo netctl stop-all && sudo netctl start $1
}

backup() {
    duplicity --encrypt-key daniel@stamer.info $1 file:///mnt/hdd/backup/$1
}

backupall(){
    for d in */ ; do
        echo BACKING UP $d
        backup $d
    done
}
