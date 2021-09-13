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

# move #
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias cda="cd ~/atcoder"

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

# Load Homebrew config script
source $HOME/.brewconfig.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# AtCoder
alias vacc="vim /Users/tohsumi/Library/Preferences/atcoder-cli-nodejs/template/main.cpp"
alias check="g++ main.cpp -o main && oj test -c ./main -d ./tests"
alias accs="acc submit"
