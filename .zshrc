### prompt setting {{{
# using zsh pure prompt (https://github.com/sindresorhus/pure)
# for left side prompt
fpath+=$HOME/.zsh/plugins/pure
autoload -U promptinit; promptinit
prompt pure

# right side prompt show exit status if not 0
function check_last_exit_status() {
	local EXIT_STATUS=$?
	if [[ $EXIT_STATUS -ne 0  ]]; then
		local RPROMPT=' '
		RPROMPT+="[ %F{red}$EXIT_STATUS%f ]"
		echo "$RPROMPT"
	fi
}

RPROMPT='$(check_last_exit_status)'
### }}}

### basic config {{{
# history settings
HISTSIZE=1048576
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt incappendhistory
setopt extendedhistory

export TERM=xterm-256color
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

### }}}

### functions {{{
# tmux simple setting
ide(){
	tmux split-window -v -p 25
	tmux split-window -h -p 50
}

# make and chenge directory
mcd() {
	mkdir "${1}" && cd "${1}"
}

# go up (n-th) directory
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
### }}}

### alias {{{
### git ###
alias gcm="git commit -m"
alias gs="git status"
alias gg="git log --all --graph --decorate --oneline"
alias ga="git add"
alias gc="git checkout"
alias gb="git branch"
alias cdgr='cd "$(git root)"'

### dotfiles ###
alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias vv="vim ~/.vimrc"
alias vt="vim ~/.tmux.conf"

# ls settings
alias ls="ls -G"
alias ll="ls -ahlF"
alias l="ls"

# disable unintended overwriting
alias cp="cp -i"
alias mv="mv -i"

# make parent directories as needed
alias mkdir="mkdir -p"
### }}}

### plugins {{{
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^ ' autosuggest-accept
### }}}

### plugins after {{{
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
### }}}

### fzf config {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
### }}}

# enable load local file {{{
if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi
### }}}

# vim: ft=zsh fdm=marker
