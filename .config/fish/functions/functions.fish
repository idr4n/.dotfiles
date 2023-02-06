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

function ff -d "search and cd into directories"
  set -l directories ~/.config ~/Dev ~/Dropbox ~/pCloud ~/Sync

  set -l sel $(fd . -H --type d -E '*.git*' -E '*node_modules*' $directories | fzf --layout=reverse --height 50% --ansi)
  if test -z "$sel"
    echo "nothing selected!"
  else if test -d "$sel"
    cd "$sel"
  else if test -f "$sel"
    cd $(dirname "$sel")
  end
end

function fa -d "search files and cd into their directories"
  set -l directories ~/.config ~/Dev ~/Dropbox ~/pCloud ~/Sync

  set -l sel $(fd . -H --type f -E '*.git*' -E '*node_modules*' $directories | \
              fzf --height 100% --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always (echo {}) --style="numbers"' --preview-window=down,60%)
  if test -z "$sel"
    echo "nothing selected!"
  else if test -d "$sel"
    cd "$sel"
  else if test -f "$sel"
    cd $(dirname "$sel")
  end
end

function fr -d "Search files and directories in current directory"
  set -l sel $(fd . -H --type f -E '*.git*' -E node_modules | \
              fzf --height 100% --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always {1} --style="numbers"' --preview-window=down,60%)
  if test -z "$sel"
    echo "nothing selected!"
  else if test -d "$sel"
    cd "$sel"
  else if test -f "$sel"
    cd $(dirname "$sel")
  end
end

function frr -d "Search with fzf/rg in current directory"
  set -l sel $(rg -n '.*' --hidden --follow --no-ignore -g '!.git/*' -g !node_modules | \
              fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always {1} --highlight-line {2} --style="numbers"' \
              --preview-window=down --preview-window +{2}-5) 

  set -l file $(echo "$sel" | cut -d ":" -f 1)
  set -l line_nr $(echo "$sel" | cut -d ":" -f 2)

  if test -z "$sel"
    echo "nothing selected!"
  else
    $EDITOR "$file" +$line_nr
  end
end

function fno -d "# search in Notes with fzf/rg"
  # set -l sel $(rg -n '.*' $HOME/Sync/Notes-Database/ | fzf --layout=reverse --height 50% --ansi) 
  set -l sel $(rg -n '.*' $HOME/Sync/Notes-zk/ $HOME/Sync/Notes-Database/ | \
              # fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi \
              fzf --delimiter=: --nth=1.. --height 100% --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always (echo {1}) --highlight-line {2} --style="numbers"' \
              --preview-window=down --preview-window +{2}-5)

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

function fuu -d "search for URLs in current directory"
  set -l sel $(rg -n 'https?://[^ ]+' --follow --no-ignore -g '!.git/*' -g !node_modules | \
              fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always {1} --highlight-line {2} --style="numbers"' \
              --preview-window=down --preview-window +{2}-5) 

  set -l url $(echo "$sel" | egrep -o 'https?://[^ )]+' | string trim --right --chars=.:)

  if test -z $url
    echo "nothing selected!"
  else
    echo "URL: $url"
    echo $url | pbcopy
    open $url
  end
end

function fu -d "search for URLs in list of directories"
  set -l directories ~/Sync/Notes-zk ~/Sync/Notes-Database

  set -l sel $(rg -n 'https?://[^ ]+' --follow --no-ignore -g '!.git/*' -g !node_modules $directories | \
              fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi \
              --preview 'bat --color=always {1} --highlight-line {2} --style="numbers"' \
              --preview-window=down --preview-window +{2}-5) 

  set -l url $(echo "$sel" | egrep -o 'https?://[^ )>]+' | string trim --right --chars=.:)

  if test -z $url
    echo "nothing selected!"
  else
    echo "URL: $url"
    echo $url | pbcopy
    open $url
  end
end

function fuc -a file -d "search for URLs in given file"
  if not test -e "$file"
    echo "not a file"
    return 1
  end

  set -l sel $(rg -N 'https?://[^ ]+' --follow "$file" | fzf --layout=reverse --height 50% --ansi)
  set -l url $(echo "$sel" | egrep -o 'https?://[^ )>]+' | string trim --right --chars=.:)

  if test -z $url
    echo "nothing selected!"
  else
    echo $url | pbcopy
    open $url
  end
end

function td -d "print all todos"
  set_color green
  echo
  cat ~/Sync/Notes-Database/todos_unimportant.md | sed 's/^/  /'
  set_color blue
  echo
  cat ~/Sync/Notes-Database/todos_eventually.md | sed 's/^/  /'
  set_color yellow
  echo
  cat ~/Sync/Notes-Database/todos_upcoming.md | sed 's/^/  /'
  set_color magenta
  echo
  cat ~/Sync/Notes-Database/todos_important.md | sed 's/^/  /'
  echo
end
