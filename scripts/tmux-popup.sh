#!/bin/bash

# Get the current session name
current_session=$(tmux display-message -p "#{session_name}")
popup_session="scratch-${current_session}"

# Function to check if we're in a popup
in_popup() {
  [[ "$(tmux display-message -p '#{session_name}')" == scratch-* ]]
}

# Function to kill the current popup session
kill_current_popup() {
  if in_popup; then
    local session_to_kill=$(tmux display-message -p '#{session_name}')
    tmux detach-client
    sleep 0.1 # Small delay to ensure detach completes
  else
    local session_to_kill="$popup_session"
    # Check if the session exists before attempting to kill it
    if ! tmux has-session -t "$session_to_kill" 2>/dev/null; then
      tmux display-message "Popup session does not exist: $session_to_kill"
      return
    fi
  fi
  if tmux kill-session -t "$session_to_kill" 2>/dev/null; then
    tmux display-message "Killed popup session: $session_to_kill"
  else
    tmux display-message "Failed to kill session: $session_to_kill"
  fi
}

# Function to kill all popup sessions
kill_all_popups() {
  if in_popup; then
    tmux detach-client
    sleep 0.1 # Small delay to ensure detach completes
  fi
  local killed=0
  local failed=0
  while read -r session; do
    if tmux kill-session -t "$session" 2>/dev/null; then
      ((killed++))
    else
      ((failed++))
    fi
  done < <(tmux list-sessions | awk '/^scratch-/{print $1}')
  tmux display-message "Killed $killed popup session(s), failed to kill $failed session(s)"
}

# Function to kill the current session and its popup
kill_current_session_and_popup() {
  local current_session=$(tmux display-message -p "#{session_name}")
  local popup_session="scratch-${current_session}"

  # Kill the popup session if it exists
  if tmux has-session -t "$popup_session" 2>/dev/null; then
    tmux kill-session -t "$popup_session"
  fi

  # Kill the current session
  tmux kill-session -t "$current_session"
  # tmux display-message "Killed current session: $current_session"
}

# Function to synchronize windows between main and popup sessions
synchronize_windows() {
  local main_windows=$(tmux list-windows -t "$current_session" -F "#{window_index}")
  local popup_windows=$(tmux list-windows -t "$popup_session" -F "#{window_index}" 2>/dev/null || echo "")

  # Remove windows from popup session that don't exist in main session
  for popup_window in $popup_windows; do
    if ! echo "$main_windows" | grep -q "$popup_window"; then
      tmux kill-window -t "$popup_session:$popup_window"
    fi
  done

  # Create windows in popup session that exist in main session
  for main_window in $main_windows; do
    if ! echo "$popup_windows" | grep -q "$main_window"; then
      local window_path=$(tmux display-message -t "$current_session:$main_window" -p "#{pane_current_path}")
      tmux new-window -t "$popup_session" -c "$window_path" -n "$main_window"
    fi
  done
}

# Function to get or create a corresponding window in the popup session
get_or_create_popup_window() {
  local current_window=$1
  local current_path=$2
  
  # Check if the window already exists in the popup session
  if ! tmux list-windows -t "$popup_session" 2>/dev/null | grep -q "^$current_window:"; then
    # If it doesn't exist, create it with the current path
    tmux new-window -t "$popup_session" -c "$current_path" -n "$current_window"
  else
    # If it exists, check if the path is different
    local popup_path=$(tmux display-message -t "$popup_session:$current_window" -p "#{pane_current_path}")
    if [ "$current_path" != "$popup_path" ]; then
      # Update the path only if it's different
      tmux send-keys -t "$popup_session:$current_window" "cd $current_path" C-m
    fi
  fi
  
  # Switch to the corresponding window
  tmux select-window -t "$popup_session:$current_window"
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  -k | --kill)
    kill_current_popup
    exit 0
    ;;
  -K | --kill-all)
    kill_all_popups
    exit 0
    ;;
  -x | --kill-session)
    kill_current_session_and_popup
    exit 0
    ;;
  *)
    echo "Unknown parameter: $1"
    exit 1
    ;;
  esac
  shift
done

# Check if we're currently in any popup
if in_popup; then
  # If we're in a popup, detach from it
  tmux detach-client
else
  # If we're not in a popup, create or attach to it
  # Calculate the width
  w_percent=80
  total_columns=$(tmux display-message -p '#{window_width}')
  percent_columns=$((total_columns * $w_percent / 100))
  if [ $percent_columns -gt 140 ]; then
    width=140
  else
    width=$percent_columns
  fi

  # Use the calculated width in the tmux popup command
  # tmux popup -xC -yC -w80% -h85% \
  tmux popup -xC -yC -w${width} -h85% \
    -b rounded \
    -S fg=magenta \
    -T "Scratch - $current_session" \
    -E "tmux new-session -A -s '$popup_session' \; set-option -t '$popup_session' status off"
fi

