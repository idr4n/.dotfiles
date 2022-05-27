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
