### prompt ###
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

### aliases ###

# git #
alias gcm="git commit -m"
alias gs="git status"
alias gitlog="git log --all --graph --decorate"
alias gitlogone="gitlog --oneline"
alias ga="git add"
alias gc="git checkout"
alias gb="git branch"
alias gp="git push"

# move #
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."

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
setopt transient_rprompt
setopt histverify
export EDITOR=vim
bindkey -v

# AtCoder
alias check="g++ main.cpp -o main && oj test -c ./main -d ./tests"
alias accs="acc submit"

# 42
alias gcca="gcc -Wall -Wextra -Werror"
alias norm="norminette"

if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi
