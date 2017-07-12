# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

prompt "paradox"


export EDITOR=vim
export PATH="$HOME/.bin:$PATH"

export GOPATH="$HOME/Development/Go"
export PATH="$GOPATH/bin:$PATH"

alias weather="curl wttr.in/Berlin"

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

backup () {
	duplicity --encrypt-key daniel@stamer.info $1 file:///mnt/hdd/backup/$1
}
