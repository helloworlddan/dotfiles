#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Daniel's exports & aliases

prompt "giddie"

export EDITOR=vim
export PATH="$HOME/.bin:$PATH"

alias x="startx && exit"

# go binaries and workspaces
export GOPATH="$HOME/Development/Go"
export PATH="$GOPATH/bin:$PATH"
alias govim="vim -u ~/.vimrc.go"

# Note taking functions

n() {
        $EDITOR ~/Notes/"$*"
}

nls() {
        ls -c ~/Notes/ | grep "$*"
}

# Weather functions

alias weather="curl wttr.in/Berlin"

# Extended git

gitup() {
	for d in */ ; do
		cd  $d
		git pull --all
		cd ..
	done
}
