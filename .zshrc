source ~/.zsh/prompt.zsh

source ~/.zsh/settings.zsh

source ~/.zsh/functions.zsh

source ~/.zsh/alias.zsh

source ~/.zsh/plugins.zsh

source ~/.zsh/plugins_after.zsh

# fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable load local file
if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi
