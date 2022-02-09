# using zsh pure prompt (https://github.com/sindresorhus/pure) 

fpath+=$HOME/.zsh/plugins/pure
autoload -U promptinit; promptinit
prompt pure
