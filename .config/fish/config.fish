set fish_greeting

if status --is-login
    set PATH $PATH /usr/bin /sbin
end

set GPG_TTY '(tty)'
set GPGKEY 9AECBF60B37C3708C1EC1FF1EDAC0E3FCB1B3FEB
set PINENTRY_USER_DATA 'USE_CURSES=1'
set EDITOR vim
set GOPATH "$HOME/Development/Go"
set PATH $PATH "$GOPATH/bin"

setenv SSH_ENV $HOME/.ssh/environment

function start_agent
	if [ -n "$SSH_AGENT_PID" ]
    		ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    		if [ $status -eq 0 ]
        		test_identities
    		end
	else
    		if [ -f $SSH_ENV ]
        		. $SSH_ENV > /dev/null
    		end
    	ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    	if [ $status -eq 0 ]
        	test_identities
    	else
    		echo "Initializing new SSH agent ..."
	        ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    		echo "succeeded"
		chmod 600 $SSH_ENV
		. $SSH_ENV > /dev/null
    		ssh-add
	end
	end
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

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
    for d in */
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
    for d in */
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

start_agent
