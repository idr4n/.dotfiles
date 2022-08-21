#!/bin/sh

directories=(
  ~/.config
  ~/Dev
  ~/Desktop
  ~/Downloads
  ~/Dropbox
  ~/pCloud
)

RESULT=$(fd . --type d -H -L -E '*.git*' -E node_modules "${directories[@]}" | fzf --layout=reverse \
  --height 100% --ansi --preview 'll {1}' --preview-window=down,60%)

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
  else
    # session exists
    echo "session exists"
    # attach to session
    # switch to tmux session
    tmux switch-client -t "$SESSION"
  fi
fi

