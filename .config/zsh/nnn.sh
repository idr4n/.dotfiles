# NNN

# bookmarks
export NNN_BMS="b:d:~/Downloads;c:~/.config;v:/Volumes"

# plugins
export NNN_PLUG="d:dropover;f:openfinder;j:autojump;c:fcd;h:fhcd;o:fzopen;l:openzathura;p:timg-preview;t:preview-tabbed;T:trash;v:imgview;z:fzcd;y:yoink;a:timg-preview-all"

# colors
export NNN_FCOLORS="c1e28D31006033f7c6d6abc4"

# terminal
# export TERMINAL="alacritty"
export TERMINAL="/usr/local/bin/kitty"

# aliases
# alias n="nnn"
# alias ls="nnn"

# do previews
export NNN_FIFO="/tmp/nnn.fifo"

export NNN_USE_EDITOR=1

# cd on quitting nnn
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    local NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -e "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

