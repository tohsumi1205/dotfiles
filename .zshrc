### prompt ###
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# history
HISTSIZE=1048576
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt incappendhistory
setopt extendedhistory


### aliases ###

# git #
alias gcm="git commit -m"
alias gs="git status"
alias gg="git log --all --graph --decorate --oneline"
alias gitlogone="gitlog --oneline"
alias ga="git add"
alias gc="git checkout"
alias gb="git branch"

# config #
export TERM=xterm-256color
alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias vv="vim ~/.vimrc"
alias vt="vim ~/.tmux.conf"
alias ll="ls -ahlF"
alias ls="ls -G"
alias l="ls"
alias cp="cp -i"
alias mv="mv -i"
alias cdgr='cd "$(git root)"'
alias mkdir="mkdir -p"
setopt auto_cd
setopt auto_pushd
setopt correct
setopt mark_dirs
setopt no_beep
setopt histverify

# use vim-like line editing in zsh
export EDITOR=vim
bindkey -v
# Undo
bindkey -a 'u' undo
bindkey -a '^R' redo
# Backspace
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
# movement
bindkey -a 'gg' beginning-of-line
bindkey -a 'G' end-of-line

# AtCoder
alias check="g++ main.cpp -o main && oj test -c ./main -d ./tests"
alias accs="acc submit"

ide(){
	tmux split-window -v -p 25
	tmux split-window -h -p 50
}

mcd() {
	mkdir "${1}" && cd "{$1}"
}

up()
{
	local cdir="$(pwd)"
	if [[ "${1}" == "" ]]; then
		cdir="$(dirname "${cdir}")"
	elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
		echo "Error: argument must be a number"
	elif ! [[ "${1}" -gt "0" ]]; then
		echo "Error: argument must be positive"
	else
		for ((i=0; i<${1}; i++)); do
			local ncdir="$(dirname "${cdir}")"
			if [[ "${cdir}" == "${ncdir}" ]]; then
				break
			else
				cdir="${ncdir}"
			fi
		done
	fi
	cd "${cdir}"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc_local ] && source ~/.zshrc_local


source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
