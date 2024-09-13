#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please install it first."
    exit 1
fi

# Function to get the current window index
get_current_window() {
    tmux display-message -p '#I'
}

# Function to list available windows
# list_windows() {
#     tmux list-windows -F '#I: #W' | grep -v "^$(get_current_window):"
# }
list_windows() {
    tmux list-windows -F '#I:#W' | grep -v "^$(tmux display-message -p '#I'):" | sed 's/:/: /'
}

# Function to move current window to a pane in another window
move_to_pane() {
    # # Get the current window index
    # current_window=$(get_current_window)
    # Get the current window index
    current_window=$(tmux display-message -p '#I')

    # Use fzf to select the target window
    target_window=$(list_windows | fzf --height 100% --reverse --prompt="Select target window: " | cut -d':' -f1)

    # Check if a window was selected
    if [ -z "$target_window" ]; then
        echo "No window selected. Exiting."
        exit 0
    fi

    # Move the current window as a vertical pane to the target window
    tmux join-pane -h -s :$current_window -t :$target_window

    # Optional: Reorder windows to fill the gap
    tmux move-window -r
}

# Function to move current pane to a new window
move_to_window() {
    # Get the current pane ID
    current_pane=$(tmux display-message -p '#D')

    # Break the current pane into a new window
    tmux break-pane -s "$current_pane"
}

# Main script logic
if [ "$1" = "to-pane" ]; then
    move_to_pane
elif [ "$1" = "to-window" ]; then
    move_to_window
else
    echo "Usage: $0 [to-pane|to-window]"
    echo "  to-pane   : Move current window to a pane in another window"
    echo "  to-window : Move current pane to a new window"
    exit 1
fi
