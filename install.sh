#!/usr/bin/env bash

set -u

git submodule update --init --recursive

for f in .??*; do
	[ "$f" = ".git" ] && continue
	
	ln -snfv ${PWD}/"$f" ~
done
