set fish_greeting

if status --is-login
    set PATH $PATH /usr/bin /sbin
end

# Power up SSH agent and add keys
if [ ! -S ~/.ssh/ssh_auth_sock ]
  eval (ssh-agent -c)
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
end

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add > /dev/null ^ /dev/null

set GPG_TTY '(tty)'
set GPGKEY 9AECBF60B37C3708C1EC1FF1EDAC0E3FCB1B3FEB
set PINENTRY_USER_DATA 'USE_CURSES=1'
set EDITOR vim
set GOPATH "$HOME/Development/Go"
set PATH $PATH "$GOPATH/bin"

function weather
    curl wttr.in/Berlin
end

function n
    $EDITOR ~/Notes/$argv
end

function nls
    ls -c ~/Notes/ | grep $argv
end

function gitup
    for d in */ ; do
        cd  $d
        git pull --all
        cd ..
    end
end

function pass
    cd ~/Documents/Passwords
    rm -f pass.yaml.gpg.back
    cp pass.yaml.gpg pass.yaml.gpg.back
    gpg -d pass.yaml.gpg > pass.yaml
    vim pass.yaml
    rm -f pass.yaml.gpg
    gpg -e -r daniel@stamer.info pass.yaml
    rm -f pass.yaml
    cd ~
end

function lan
    sudo netctl stop-all; and sudo netctl start $argv
end

function backup
    duplicity --encrypt-key daniel@stamer.info $argv file:///mnt/hdd/backup/$argv
end

function backupall
    for d in */ ; do
        echo BACKING UP $d
        backup $d
    end
end

function backupstats
    duplicity collection-status file:///mnt/hdd/backup/$argv
end

function trek
    play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +30 fade h 1 86400 1
end

function noise
    play -n synth brownnoise synth pinknoise mix synth sine amod 0 10
end
