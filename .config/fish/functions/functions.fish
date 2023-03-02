# Functions

#: __shorten {{{
function __shorten -d "shortens the string if length greater than 30 characters"
    if test (string length $argv[1]) -gt 30
        echo -n (string sub --length 28 $argv[1])".."
    else
        string sub --length 30 $argv[1]
    end
end
#: }}}

#: cs {{{
function cs -d "Fuction to run ls after cd"
    cd "$argv" && ls
end
#: }}}

#: mkcd {{{
function mkcd -d "Fuction to cd into just created dir"
    mkdir -p "$argv"; cd "$argv"
end
#: }}}

#: mkf Function to create file and together with path recursively. {{{
function mkf -d "creates file together with path recursively"
    set -l dir $(dirname "$argv")
    set -l file $(basename "$argv")
    mkcd "$dir"
    touch "$file" 
    if test -f $file
        echo "Created file '$file' under directory '$dir'"
    end
end
#: }}}

#: ff -d "search and cd into directories" {{{
function ff -d "search and cd into directories"
    set -l directories ~/.config ~/Dev ~/Dropbox ~/pCloud ~/Sync

    set -l sel $(fd . -H --type d -E '*.git*' -E '*node_modules*' $directories | fzf --layout=reverse --height 50% --ansi --border-label  " ff - search directories in given list - cd ")
    if test -z "$sel"
        echo "nothing selected!"
    else if test -d "$sel"
        cd "$sel"
    else if test -f "$sel"
        cd $(dirname "$sel")
    end
end
#: }}}

#: F -d "search in given list - open" {{{
function F -d "search in given list - open"
    set -l last_query $(tail -n 1 $HOME/.fzf_history)
    set -l directories ~/pCloud ~/Sync ~/Downloads
    set -l REVEAL "ctrl-y:execute-silent(open -R {})+execute-silent(echo {q} >> $HOME/.fzf_history)+abort"
    set -l HEADER "CTRL-Y: reveal in Finder."

    set -l sel $(fd . -H -E '*.git*' -E '*node_modules*' $directories | fzf --layout=reverse \
        --height 100% --ansi \
        --border-label  " ff - search in given list - open " \
        --query="$last_query" \
        --header $HEADER \
        --bind "$REVEAL")
    if test -z "$sel"
        echo "nothing selected!"
    else
        open "$sel"
    end
end
#: }}}

#: fa -d "search files and cd into their directories" {{{
function fa -d "search files and cd into their directories"
    set -l directories ~/.config ~/Dev ~/Dropbox ~/pCloud ~/Sync

    set -l sel $(fd . -H --type f -E '*.git*' -E '*node_modules*' $directories | \
        fzf --height 100% --layout=reverse --info=inline --ansi --border-label  " fa - search files in given list - cd " \
        --preview 'bat --color=always (echo {}) --style="numbers"' --preview-window=down,60%)
    if test -z "$sel"
        echo "nothing selected!"
    else if test -d "$sel"
        cd "$sel"
    else if test -f "$sel"
        cd $(dirname "$sel")
    end
end
#: }}}

#: fr -d "Search files and directories in current directory" {{{
function fr -d "Search files and directories in current directory"
    set -l sel $(fd . -H --type f -E '*.git*' -E node_modules | \
        fzf --height 100% --layout=reverse --info=inline --ansi --border-label  " fr - search files and directories in current directory - cd " \
        --preview 'bat --color=always {1} --style="numbers"' --preview-window=down,60%)
    if test -z "$sel"
        echo "nothing selected!"
    else if test -d "$sel"
        cd "$sel"
    else if test -f "$sel"
        cd $(dirname "$sel")
    end
end
#: }}}

#: frr -d "Search with fzf/rg in current directory" {{{
function frr -d "Search with fzf/rg in current directory"
    set -l sel $(rg -n '.*' --hidden --follow --no-ignore -g '!.git/*' -g !node_modules | \
        fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi --border-label  " frr - search lines in current directory - open in Nvim " \
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
#: }}}

#: fno -d "# search in Notes with fzf/rg" {{{
function fno -d "# search in Notes with fzf/rg"
    # set -l sel $(rg -n '.*' $HOME/Sync/Notes-Database/ | fzf --layout=reverse --height 50% --ansi) 
    set -l sel $(rg -n '.*' $HOME/Sync/Notes-zk/ $HOME/Sync/Notes-Database/ | \
        # fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi \
        fzf --delimiter=: --nth=1.. --height 100% --layout=reverse --info=inline --ansi --border-label  " fno - search in Notes directories - open in Nvim" \
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
#: }}}

#: f -d "search recent workdirs set in Neovim" {{{
function f -d "search recent workdirs set in Neovim"
    set -l sel $(cat ~/.config/nvim/lua/workdirs.txt | fzf --layout=reverse --height 50% --ansi --border-label  " f - search recent workdirs - cd ")
    if test -z "$sel"
        echo "nothing selected!"
    else if test -d "$sel"
        cd "$sel"
    else if test -f "$sel"
        cd $(dirname "$sel")
    end
end
#: }}}

#: fuu -d "search for URLs in current directory" {{{
function fuu -d "search for URLs in current directory"
    set -l sel $(rg -n 'https?://[^ ]+' --follow --no-ignore -g '!.git/*' -g !node_modules | \
        fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi \
        --border-label  " fuu - search URLs in current directory - open in browser " \
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
#: }}}

#: fu -d "search for URLs in list of directories" {{{
function fu -d "search for URLs in list of directories"
    set -l directories ~/Sync/Notes-zk ~/Sync/Notes-Database

    set -l sel $(rg -n 'https?://[^ ]+' --follow --no-ignore -g '!.git/*' -g !node_modules $directories | \
        fzf --delimiter=: --nth=2.. --height 100% --layout=reverse --info=inline --ansi --border-label  " fu - search URLs in given list of directories - open in browser " \
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
#: }}}

#: fuc -a file -d "search for URLs in given file" {{{
function fuc -a file -d "search for URLs in given file"
    if not test -e "$file"
        echo "not a file"
        return 1
    end

    set -l sel $(rg -N 'https?://[^ ]+' --follow "$file" | fzf --layout=reverse --height 50% --ansi --border-label  " fuc - search URLs in current file - open in browser " )
    set -l url $(echo "$sel" | egrep -o 'https?://[^ )>]+' | string trim --right --chars=.:)

    if test -z $url
        echo "nothing selected!"
    else
        echo $url | pbcopy
        open $url
    end
end
#: }}}

#: ft -d "search for tagged dirs and files" {{{
function ft -d "search for tagged dirs and files"
    set -l last_query $(tail -n 1 $HOME/.fzf_history)
    set -l REVEAL "ctrl-y:execute-silent(open -R (string replace -r '^~' '$HOME' {}))+execute-silent(echo {q} >> $HOME/.fzf_history)+abort"
    set -l HEADER "CTRL-Y: reveal in Finder."

    set -l sel $(cat ~/Sync/file_tags.txt | sort | fzf --layout=reverse \
        --height 100% --ansi \
        --query="$last_query" \
        --header $HEADER \
        --bind "$REVEAL" \
        --border-label  " ft - search tagged dirs and files - open ")
    set -l sel (string replace -r '^~' "$HOME" $sel)
    if test -z "$sel"
        echo "nothing selected!"
    else
        open "$sel"
    end
end
#: }}}
