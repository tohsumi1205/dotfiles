#!/usr/bin/env bash

# todo
#  install bat ripgrep tmux vim(latest)

set -u

git submodule update --init --recursive

for f in .??*; do
	[ "$f" = ".git" ] && continue
	[ "$f" = ".gitmodules" ] && continue
	
	ln -snfv ${PWD}/"$f" ~
done

# install vim plugins
vim -c PackUpdate .vimrc -c q

~/.vim/pack/minpac/start/fzf/install

echo -e "\n\n\033[32m need to install bat ripgrep tmux vim(latest version) for usability\033[m"
