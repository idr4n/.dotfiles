#!/bin/sh

name=$1

sessions=(
  "Dev"
  "Config"
  "Work"
  "Sandbox"
)

proj_dirs_file="$HOME/projects-dirs"  # Replace with the path to your file
confs_dirs_file="$HOME/confs-dirs"  # Replace with the path to your file
work_dirs_file="$HOME/work-dirs"  # Replace with the path to your file

# Check if projects directory file exists
if [ ! -f "$proj_dirs_file" ]; then
  echo "Directory file $proj_dirs_file not found. Creating..."
  touch "$proj_dirs_file"
  # Add initial directories to the file, if needed
  echo "$HOME/pCloud/Dev" >> "$proj_dirs_file"
fi

# Check if configs directory file exists
if [ ! -f "$confs_dirs_file" ]; then
  echo "Directory file $confs_dirs_file not found. Creating..."
  touch "$proj_dirs_file"
  # Add initial directories to the file, if needed
  echo "$HOME/.config/nvim" >> "$confs_dirs_file"
fi

# Check if configs directory file exists
if [ ! -f "$work_dirs_file" ]; then
  echo "Directory file $work_dirs_file not found. Creating..."
  touch "$work_dirs_file"
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
        # tmux new-session -d -s "$RESULT" -c ~/.config/nvim\; new-window -c ~/dotfiles -d\; new-window -c ~/.config/wezterm -d
        tmux new-session -d -s "$RESULT" -c $(head -1 $confs_dirs_file)
        # Loop through dirs in file and create a window for each
        tail -n +2 "$confs_dirs_file" | while read -r dir; do
          tmux new-window -t Config -c "$dir" -d
        done
        ;;
      Work)
        # tmux new-session -d -s "$RESULT" -c ~/pCloud/Notes-Database
        tmux new-session -d -s "$RESULT" -c $(head -1 $work_dirs_file)
        # Loop through dirs in file and create a window for each
        tail -n +2 "$work_dirs_file" | while read -r dir; do
          tmux new-window -t Work -c "$dir" -d
        done
        ;;
      Dev)
        tmux new-session -d -s "$RESULT" -c $(head -1 $proj_dirs_file)
        # Loop through dirs in file and create a window for each
        tail -n +2 "$proj_dirs_file" | while read -r dir; do
          tmux new-window -t Dev -c "$dir" -d
        done
        ;;
      Sandbox)
        tmux new-session -d -s "$RESULT" -c ~/pCloud/Dev/Sandboxes
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
        # tmux new-session -d -s "$RESULT" -c ~/.config/nvim
        # tmux switch-client -t "$RESULT"\; new-window -c ~/dotfiles -d
        # tmux switch-client -t "$RESULT"\; new-window -c ~/.config/wezterm -d
        tmux new-session -d -s "$RESULT" -c $(head -1 $confs_dirs_file) 
        # Loop through dirs in file and create a window for each
        tail -n +2 "$confs_dirs_file" | while read -r dir; do
          tmux new-window -t Config -c "$dir" -d
        done
        tmux switch-client -t "$RESULT"
        ;;
      Work)
        # tmux new-session -d -s "$RESULT" -c ~/pCloud/Notes-Database
        tmux new-session -d -s "$RESULT" -c $(head -1 $work_dirs_file) 
        # Loop through dirs in file and create a window for each
        tail -n +2 "$work_dirs_file" | while read -r dir; do
          tmux new-window -t Work -c "$dir" -d
        done
        tmux switch-client -t "$RESULT"
        ;;
      Dev)
        tmux new-session -d -s "$RESULT" -c $(head -1 $proj_dirs_file) 
        # Loop through dirs in file and create a window for each
        tail -n +2 "$proj_dirs_file" | while read -r dir; do
          tmux new-window -t Dev -c "$dir" -d
        done
        tmux switch-client -t "$RESULT"
        ;;
      Sandbox)
        tmux new-session -d -s "$RESULT" -c ~/pCloud/Dev/Sandboxes
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
