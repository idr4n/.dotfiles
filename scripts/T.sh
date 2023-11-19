#!/bin/sh

directories=(
  ~/.config
  ~/Dev
  ~/Desktop
  ~/Downloads
  ~/Dropbox
  ~/Sync
  ~/pCloud
)

FZF_BORDER_LABEL=" T - Tmux New Session - Selected Dirs "

RESULT=$(fd . --type d -H -L -E '*.git*' -E node_modules "${directories[@]}" | fzf --border-label "$FZF_BORDER_LABEL" --layout=reverse --height 100%)

# if not currently in tmux
if [ -z "$TMUX" ]; then
  # tmux is not active
  echo "is not tmux"

  # if empty exit
  if [ -z "$RESULT" ]; then
    exit 0
  fi

  FOLDER=$(basename "$RESULT")

  # lookup tmux session name
  SESSION=$(tmux list-sessions | grep "$FOLDER" | awk '{print $1}')
  SESSION=${SESSION//:/}

  if [ -z "$SESSION" ]; then
    # session does not exist
    echo "session does not exist"
    # jump to directory
    cd "$RESULT"
    # create session
    tmux new-session -s "$FOLDER"
  else
    # session exists
    echo "session exists"
    # attach to session
    tmux attach -t "$SESSION"
  fi
  zoxide add "$RESULT"
else
  # tmux is active
  echo "is tmux"

  # if no result exit
  if [ -z "$RESULT" ]; then
    exit 0
  fi

  FOLDER=$(basename "$RESULT")
  # lookup tmux session name
  SESSION=$(tmux list-sessions | grep "$FOLDER" | awk '{print $1}')
  SESSION=${SESSION//:/}

  if [ -z "$SESSION" ]; then
    # session does not exist
    echo "session does not exist"
    # jump to directory
    cd "$RESULT"
    # create session
    tmux new-session -d -s "$FOLDER"
    # attach to session
    tmux switch-client -t "$FOLDER"
    zoxide add "$RESULT"
  else
    # session exists
    echo "session exists"
    # attach to session
    # switch to tmux session
    tmux switch-client -t "$SESSION"
  fi
fi
