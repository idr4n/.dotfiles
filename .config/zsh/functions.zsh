# Function to find directory with fzf
function cdf () {
  # cd "$(find * -type d | fzf)"
  cd "$(fd -t d | fzf)"
}

# Fuction to run ls after cd
function cs () {
  cd "$@" && ls
}
# Fuction to run la after cd
function ca () {
  cd "$@" && la
}
# Fuction to cd into just created dir
function mkcd () {
  mkdir -p "$1" && cd "$1"
}
# Function to create file and together with path recursively.
function mkf () {
  DIR=$(dirname "$1")
  FILE=$(basename "$1")
  mkcd "${DIR}" && touch "${FILE}" 
}

# Fucntion to print tree
function lt() {
  if [[ $# -gt 0 ]]; then
    eza --icons -a --tree --level=$1 -I "node_modules|.git"
  else
    # use lta alias above to print all levels
    eza --icons -a --tree --level=3 -I "node_modules|.git"
  fi
}

# search in Notes with fzf/rg
function fno () { 
    sel=$(rg -n '.*' "$HOME/Dropbox/Notes-Database/" | fzf --layout=reverse --height 50% --ansi); 
    file=$(echo "$sel" | cut -d ":" -f 1)
    line_nr=$(echo "$sel" | cut -d ":" -f 2)

    [ -z $sel ] && echo "nothing selected!" && return

    $EDITOR $file +$line_nr
    # subl -n "$(dirname $file)" && subl $file:$line_nr
}

# Search in current directory
function fr () { 
    # sel=$(rg -n '.*' "." | fzf --layout=reverse --height 50% --ansi); 
    # file=$(echo "$sel" | cut -d ":" -f 1)
    # line_nr=$(echo "$sel" | cut -d ":" -f 2)

    # [ -z $sel ] && echo "nothing selected!" && return

    # $EDITOR $file +$line_nr
    # subl -n "$(dirname $file)" && subl $file:$line_nr

    sel=$(fd . | fzf --layout=reverse --height 50% --ansi); 

    [ -z "$sel" ] && echo "nothing selected!" && return
    [ -d "$sel" ] && cd "$sel" && return
    [ -f "$sel" ] && cd "$(dirname "$sel")" && return
}

# search files and cd into their directories
function f () {
    directories=(
        ~/.config
        ~/Dev
        ~/Dropbox
        ~/pCloud
    )

    sel=$(fd . -H "${directories[@]}" | fzf --layout=reverse --height 50% --ansi); 

    [ -z "$sel" ] && echo "nothing selected!" && return
    [ -d "$sel" ] && cd "$sel" && return
    [ -f "$sel" ] && cd "$(dirname "$sel")" && return
}

# search files and nnn into their directories
function fn () {
    directories=(
        ~/.config
        ~/Dev
        ~/Dropbox
        ~/pCloud
    )

    sel=$(fd . -H "${directories[@]}" | fzf --layout=reverse --height 50% --ansi); 

    [ -z "$sel" ] && echo "nothing selected!" && return
    n "$sel"
}

# search files and open folder in Sublime Text
function fs () {
    directories=(
        ~/.config
        ~/Dev
        ~/Dropbox
        ~/pCloud
    )

    sel=$(fd . -H "${directories[@]}" | fzf --layout=reverse --height 50% --ansi); 

    [ -z "$sel" ] && echo "nothing selected!" && return
    subl -n "$sel"
}
