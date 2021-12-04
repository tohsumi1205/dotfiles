#!/usr/bin/env bash

set -u

for f in .??*; do
	[ "$f" = ".git" ] && continue
	
	ln -snfv ${PWD}/"$f" ~
done
