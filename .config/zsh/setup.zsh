#: Misc {{{

zmodload zsh/complist
zle_highlight=('paste:none')

# bindings
bindkey -M menuselect '^[[Z' reverse-menu-complete

#: }}}


#: Opts {{{

unsetopt BEEP
setopt AUTO_CD
setopt GLOB_DOTS
setopt NOMATCH
setopt MENU_COMPLETE
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt APPEND_HISTORY

# history opts
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#: }}}


#: Exports {{{

# FZF
export FZF_DEFAULT_COMMAND='fd --type file --follow'
export FZF_CTRL_T_COMMAND='fd --type file --follow'
# export FZF_DEFAULT_OPTS="--reverse --history='$HOME/.fzf_history' --border rounded --height 100% --info=right --prompt='  ' --pointer='•' --marker=' ' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:#FF87D7,hl+:#FF87D7,header:2,separator:#FF87D7,info:4,label:4,pointer:#FF87D7,prompt:#828BB8,query:#828BB8"

# export FZF_DEFAULT_OPTS="--reverse --history='$HOME/.fzf_history' --border rounded --height 100% --info=right --prompt='  ' --pointer='•' --marker=' ' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:#FF87D7,hl+:#FF87D7,header:2,separator:#FF87D7,info:4,label:4,pointer:#FF87D7,prompt:#828BB8,query:#828BB8 --info-command='echo -e \"\x1b[33;1m\$FZF_POS\x1b[m/\$FZF_INFO 💛\"'"

export FZF_DEFAULT_OPTS="--reverse --history='$HOME/.fzf_history' --border rounded --height 100% --info=right --prompt='  ' --pointer='•' --marker=' ' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:#FF87D7,hl+:#FF87D7,header:2,separator:#FF87D7,info:4,label:4,pointer:#FF87D7,prompt:#828BB8,query:#828BB8 --info-command='echo \"\$FZF_INFO (\x1b[33;1m\$FZF_POS\x1b[m) 💛\"'"

# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# BAT
export BAT_THEME=Nord

# Ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.rgrc

# tdo env variable
export NOTES_DIR=$HOME/pCloud/Notes-tdo

# private env variables
source $HOME/.environment_zsh

# Terminal background
export TERMBG=$(python3 $ZDOTDIR/bgenv.py) 

# typst
export TYPST_ROOT="$HOME"

# imagemagic
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"

#: }}}

