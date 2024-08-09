#!/bin/bash

# alacritty --working-directory "$PWD" &

# Set default directory to the current working directory
dir="$PWD"

# If an argument is provided, use it as the directory
if [ $# -gt 0 ]; then
  dir="$1"
fi

# Ensure the directory path is absolute
# dir="$(cd "$dir" && pwd)"

# Launch Alacritty with the specified directory
# alacritty --working-directory "$dir" &
open -n -a alacritty --args --working-directory "$dir" &

# Uncomment the following line for debugging
# echo "Opening Alacritty in directory: $dir"
