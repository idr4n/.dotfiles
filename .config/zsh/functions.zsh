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
function lt () {
  if [[ $# -gt 0 ]]; then
    eza --icons -a --tree --level=$1 -I "node_modules|.git"
  else
    # use lta alias above to print all levels
    eza --icons -a --tree --level=3 -I "node_modules|.git"
  fi
}

# Search in current directory
function fr () { 
  sel=$(fd "$1" | fzf --layout=reverse --height 50% --ansi); 

  [ -z "$sel" ] && echo "nothing selected!" && return
  [ -d "$sel" ] && cd "$sel" && return
  [ -f "$sel" ] && cd "$(dirname "$sel")" && return
}

# Search recent workdirs (zoxide)
function f () {
  sel=$(zoxide query "$1" -l | fzf --layout=reverse --height 100% --ansi --border-label  " f - search recent directory (zoxide) ")

  [ -z "$sel" ] && echo "nothing selected!" && return
  [ -d "$sel" ] && cd "$sel" && return
  [ -f "$sel" ] && cd "$(dirname "$sel")" && return
}

# search and cd into their directories
function ff () {
  directories=(
    ~/.config
    ~/Dev
    ~/pCloud
  )

  sel=$(fd "$1" -H "${directories[@]}" | fzf --layout=reverse --height 100% --ansi --border-label  " ff - search in given list and cd "); 

  [ -z "$sel" ] && echo "nothing selected!" && return
  [ -d "$sel" ] && cd "$sel" && return
  [ -f "$sel" ] && cd "$(dirname "$sel")" && return
}

# search noets file names and open with Nvim
function fn () {
  directories=(
    ~/pCloud/Notes-tdo
    ~/pCloud/Notes-Database
  )

  HEADER="CTRL-N: Create New Note."
  CREATE='ctrl-n:execute-silent(open -na alacritty --args --working-directory ~/pCloud/Notes-tdo -e "tdo {q}")+abort'

  sel=$(fd "$1" -e md -I -E "{**/.obsidian,**/.vscode}"  --type f "${directories[@]}" | fzf --height 100% --layout=reverse --info=inline --ansi --border-label  " fn - search noets file names and open with Nvim " \
    --preview 'cat "$(echo {})" --style="numbers"' --preview-window=down,60% \
    --header $HEADER \
    --bind "$CREATE")

  [ -z "$sel" ] && echo "nothing selected!" && return
  [ -f "$sel" ] && $EDITOR "$sel" -c "cd $(dirname "$sel")" && return
}

#search in Notes directories - open in Nvim
function fno () { 
  directories=(
    ~/pCloud/Notes-tdo
    ~/pCloud/Notes-Database
  )

  sel=$(rg "$1" -g "!{**/.obsidian,**/.vscode}" -n "${directories[@]}" | fzf --delimiter=: --nth=1.. --height 100% --layout=reverse --info=inline --ansi --border-label  " fno - search in Notes directories - open in Nvim " \
    --preview 'bat --color=always "$(echo {1})" --highlight-line {2} --style="numbers"' \
    --preview-window=down --preview-window +{2}-5)

  file=$(echo "$sel" | cut -d ":" -f 1)
  line_nr=$(echo "$sel" | cut -d ":" -f 2)

  [ -z $sel ] && echo "nothing selected!" && return

  $EDITOR "$file" +$line_nr -c "cd $(dirname "$sel")"
}

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -i | fzf --ansi --height 50% --reverse --border-label ' sesh ' --border --prompt $'\e[33;1m⚡\e[m  ')
    [[ -z "$session" ]] && echo "No session provided!" && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
