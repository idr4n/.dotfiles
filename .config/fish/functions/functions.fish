# Functions

function __shorten -d "shortens the string if length greater than 10 characters"
  if test (string length $argv[1]) -gt 10
    echo -n (string sub --length 8 $argv[1])".."
  else
    string sub --length 10 $argv[1]
  end
end

function cs -d "Fuction to run ls after cd"
  cd "$argv" && ls
end

function mkcd -d "Fuction to cd into just created dir"
  mkdir -p "$argv"; cd "$argv"
end

# Function to create file and together with path recursively.
function mkf 
  set -l dir $(dirname "$argv")
  set -l file $(basename "$argv")
  mkcd "$dir"
  touch "$file" 
  if test -f $file
    echo "Created file '$file' under directory '$dir'"
  end
end

function f -d "search files and cd into their directories"
  set -l directories ~/.config ~/Dev ~/Dropbox ~/pCloud

  set -l sel $(fd . -H $directories | fzf --layout=reverse --height 50% --ansi)
  if test -z "$sel"
    echo "nothing selected!"
  else if test -d "$sel"
    cd "$sel"
  else if test -f "$sel"
    cd $(dirname "$sel")
  end
end

function fr -d "Search in current directory"
  set -l sel $(fd . | fzf --layout=reverse --height 50% --ansi)
  if test -z "$sel"
    echo "nothing selected!"
  else if test -d "$sel"
    cd "$sel"
  else if test -f "$sel"
    cd $(dirname "$sel")
  end
end

function fno -d "# search in Notes with fzf/rg"
  set -l sel $(rg -n '.*' $HOME/Dropbox/Notes-Database/ | fzf --layout=reverse --height 50% --ansi) 

  set -l file $(echo "$sel" | cut -d ":" -f 1)
  set -l line_nr $(echo "$sel" | cut -d ":" -f 2)

  if test -z "$sel"
    echo "nothing selected!"
  else
    $EDITOR "$file" +$line_nr
  end
end
