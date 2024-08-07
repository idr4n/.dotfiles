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
      echo "Popup session does not exist: $session_to_kill"
      return
    fi
  fi
  if tmux kill-session -t "$session_to_kill" 2>/dev/null; then
    echo "Killed popup session: $session_to_kill"
  else
    echo "Failed to kill session: $session_to_kill"
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
      echo "Killed session: $session"
      ((killed++))
    else
      echo "Failed to kill session: $session"
      ((failed++))
    fi
  done < <(tmux list-sessions | awk '/^scratch-/{print $1}')
  echo "Killed $killed popup session(s), failed to kill $failed session(s)"
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
  tmux popup -xC -yC -w80% -h80% \
    -b rounded \
    -S fg=magenta \
    -T "Scratch - $current_session" \
    -E "tmux new-session -A -s '$popup_session' \; set-option -t '$popup_session' status off"
fi