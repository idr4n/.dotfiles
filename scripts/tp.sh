#!/bin/sh

ZOXIDE_RESULT=$(zoxide query -l | fzf --border-label "Split pane with selected dir" --height 100% --layout=reverse)

if [ -z "$ZOXIDE_RESULT" ]; then
	echo "nothing selected!"
	exit 0
else
	tmux split-window -h -c "$ZOXIDE_RESULT"
fi
