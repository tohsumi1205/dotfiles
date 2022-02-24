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
