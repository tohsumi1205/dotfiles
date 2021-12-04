### prompt ###
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

function check_last_exit_status() {
	local EXIT_STATUS=$?
	if [[ $EXIT_STATUS -ne 0 ]]; then
		local RPROMPT=' '
		RPROMPT+="[ %F{red}$EXIT_STATUS%f ]"
		echo "$RPROMPT"
	fi
}

RPROMPT='$(check_last_exit_status)'

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
alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias vv="vim ~/.vimrc"
alias vt="vim ~/.tmux.conf"
alias ll="ls -alF"
alias ls="ls -G"
alias l="ls"
alias v="vim"
alias mkdir="mkdir -p"
setopt auto_cd
setopt auto_pushd
setopt correct
setopt mark_dirs
setopt no_beep
setopt histverify
export EDITOR=vim
bindkey -v

# AtCoder
alias check="g++ main.cpp -o main && oj test -c ./main -d ./tests"
alias accs="acc submit"

# 42
alias gcca="gcc -Wall -Wextra -Werror"
alias norm="norminette"
function 42header(){
	for f in ./*.c ./*.h ; do vim -c Stdheader'' -c 'wq' $f ; done
}

function ide(){
	tmux split-window -v -p 25
	tmux split-window -h -p 50
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

if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi
