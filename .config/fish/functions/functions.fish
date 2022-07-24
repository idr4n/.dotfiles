# Functions

function __shorten -d "shortens the string if length greater than 30 characters"
  if test (string length $argv[1]) -gt 30
    echo -n (string sub --length 28 $argv[1])".."
  else
    string sub --length 30 $argv[1]
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

function ff -d "search files and cd into their directories"
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

function frr -d "Search with fzf/rg in current directory"
  set -l sel $(rg -n '.*' -g !node_modules | fzf --delimiter=: --nth=2.. --height 50% \
              --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always {1} --highlight-line {2} --style="numbers"' \
              --preview-window +{2}-5) 

  set -l file $(echo "$sel" | cut -d ":" -f 1)
  set -l line_nr $(echo "$sel" | cut -d ":" -f 2)

  if test -z "$sel"
    echo "nothing selected!"
  else
    $EDITOR "$file" +$line_nr
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

function f -d "search recent workdirs set in Neovim"
  set -l sel $(cat ~/.config/nvim/lua/workdirs.txt | fzf --layout=reverse --height 50% --ansi)
  if test -z "$sel"
    echo "nothing selected!"
  else if test -d "$sel"
    cd "$sel"
  else if test -f "$sel"
    cd $(dirname "$sel")
  end
end

function tt -d "print all todos"
  echo
  set_color green
  cat ~/Dropbox/Notes-Database/todos_unimportant.md | sed 's/^/  /'
  set_color blue
  cat ~/Dropbox/Notes-Database/todos_eventually.md | sed 's/^/  /'
  set_color yellow
  cat ~/Dropbox/Notes-Database/todos_upcoming.md | sed 's/^/  /'
  set_color magenta
  cat ~/Dropbox/Notes-Database/todos_important.md | sed 's/^/  /'
  echo
end
