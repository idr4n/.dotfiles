#!/bin/sh

name=$1

sessions=(
  "Dev"
  "Config"
  "Work"
  "Sandbox"
)

dirs_file="$HOME/projects-dirs"  # Replace with the path to your file

# Check if directory file exists
if [ ! -f "$dirs_file" ]; then
  echo "Directory file $dirs_file not found. Creating..."
  touch "$dirs_file"
  # Add initial directories to the file, if needed
  echo "~/Sync/Dev" >> "$dirs_file"
fi

FZF_BORDER_LABEL=" TT - Tmux New Session - Defined Sessions "

if [ -z "$name" ]; then
  RESULT=$(printf '%s\n' "${sessions[@]}" | fzf --border-label "$FZF_BORDER_LABEL" --layout=reverse --height 100%)
else
  RESULT=$name
fi

# lookup tmux session name
SESSION=$(tmux list-sessions 2> /dev/null | grep "$RESULT" | awk '{print $1}')

# if not currently in tmux
if [ -z "$TMUX" ]; then
  # tmux is not active
  echo "is not tmux"

  # if empty exit
  if [ -z "$RESULT" ]; then
    exit 0
  fi

  if [ -z "$SESSION" ]; then
    # session does not exist
    echo "session does not exist"
    # create session
    case $RESULT in
      Config)
        tmux new-session -d -s "$RESULT" -c ~/dotfiles\; new-window -c ~/.config/nvim
        ;;
      Work)
        tmux new-session -d -s "$RESULT" -c ~/Sync/Notes-Database
        ;;
      Dev)
        tmux new-session -d -s "$RESULT" -c $(head -1 $dirs_file)
        # Loop through dirs in file and create a window for each
        tail -n +2 "$dirs_file" | while read -r dir; do
          tmux new-window -t Dev -c "$dir" -d
        done
        ;;
      Sandbox)
        tmux new-session -d -s "$RESULT" -c ~/Sync/Dev/Sandboxes
        ;;
      *)
        tmux new-session -d -s "$RESULT"
    esac
    tmux attach
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

  if [ -z "$SESSION" ]; then
    # session does not exist
    echo "session does not exist"
    # create session
    # tmux new-session -d -s "$RESULT"
    # attach to session
    # tmux switch-client -t "$RESULT"
    case $RESULT in
      Config)
        tmux new-session -d -s "$RESULT" -c ~/dotfiles
        tmux switch-client -t "$RESULT"\; new-window -c ~/.config/nvim
        ;;
      Work)
        tmux new-session -d -s "$RESULT" -c ~/Sync/Notes-Database
        tmux switch-client -t "$RESULT"
        ;;
      Dev)
        tmux new-session -d -s "$RESULT" -c $(head -1 $dirs_file) 
        # Loop through dirs in file and create a window for each
        tail -n +2 "$dirs_file" | while read -r dir; do
          tmux new-window -t Dev -c "$dir" -d
        done
        tmux switch-client -t "$RESULT"
        ;;
      Sandbox)
        tmux new-session -d -s "$RESULT" -c ~/Sync/Dev/Sandboxes
        tmux switch-client -t "$RESULT"
        ;;
      *)
        tmux new-session -d -s "$RESULT"
        tmux switch-client -t "$RESULT"
    esac
  else
    # session exists
    echo "session exists"
    # attach to session
    # switch to tmux session
    tmux switch-client -t "$SESSION"
  fi
fi
