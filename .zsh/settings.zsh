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
