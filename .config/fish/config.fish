# Fish shell config

#: Greeting {{{

# set -U fish_greeting only once in the command line or,
set -g fish_greeting

#: }}}

#: Set EDITOR {{{

# set -gx NVIM_APPNAME LazyVim
# set -gx NVIM_APPNAME NvChad
set -gx EDITOR nvim

#: }}}

#: XDG_CONFIG_HOME {{{
set -gx XDG_CONFIG_HOME $HOME/.config
#: }}}

#: Private env {{{
source $HOME/.environment
#: }}}

#: nnn env variables {{{

# bookmarks
set -gx NNN_BMS "b:~/pCloud/Books;d:~/Downloads;p:~/pCloud/PSU;q:~/pCloud/PSU/Econ103/Econ103-2021-II;w:~/pCloud/PSU/Econ207/Econ207-2021-II;c:~/.config;v:/Volumes"
# plugins
set -gx NNN_PLUG "d:dropover;f:openfinder;j:autojump;c:fcd;h:fhcd;o:fzopen;l:openzathura;p:timg-preview;t:preview-tabbed;T:trash;v:imgview;z:fzcd;y:yoink;a:timg-preview-all"
# colors
set -gx NNN_FCOLORS "c1e28D31006033f7c6d6abc4"
# terminal
set -gx TERMINAL $(echo $(which alacritty))
set -gx NNN_USE_EDITOR 1

#: }}}

#: Bat env variable {{{

set t (math (date +%H) + (date +%M)/60)
# if [ $t -gt 8 ]
if test $t -gt 7; and test $t -lt 18
    # set -gx BAT_THEME "gruvbox-light"
    set -gx BAT_THEME Nord
else
    set -gx BAT_THEME Nord
end

#: }}}

#: Nvim config switcher {{{
alias l="NVIM_APPNAME=LazyVim nvim"
alias a="NVIM_APPNAME=AstroNvim nvim"
alias v="NVIM_APPNAME=NvChad nvim"
alias lk="NVIM_APPNAME=LazyKick nvim"
#: }}}

#: tdo env variable {{{
set -gx PATH $PATH $HOME/.local/bin
set -gx NOTES_DIR $HOME/pCloud/Notes-tdo
# set -gx ADD_ENTRY_TIMESTAMP true
# set -gx FILE_NAME_AS_TITLE true
# set -gx NOTES_DIR $HOME/pCloud/Notes-tdo-test
#: }}}

#: Ripgrep {{{
set -gx RIPGREP_CONFIG_PATH $HOME/.rgrc
#: }}}

#: Abbreviations {{{
abbr -a lr --set-cursor "exa --icons -la | rg '%'"
abbr -a \*\* --position anywhere --set-cursor "(fd . --type d -H -E '*.git*' -E '*node_modules*' | fzf)"
abbr -a gco --set-cursor "git checkout"
abbr -a wp --set-cursor "echo -n (which %) | pbcopy"
# abbr 
#: }}}

#: Aliases {{{
# alias ls='lsd'
alias ls='eza --icons'
alias ll='ls -al'
alias la='ls -a'
alias lta='la --tree -I node_modules -I .git'
alias c='clear'
alias oo='cd ~/dotfiles'
alias oc='cd ~/.config'
alias on='cd ~/.config/nvim'
alias ot="cd ~/pCloud/Notes-tdo"
alias pd='pwd'
alias up='cd ..'
alias tm='tmux'
alias ts='~/dotfiles/scripts/TT.sh'
alias tw='ts Work'
alias tc='ts Config'
alias tl='ts Dev'
alias pc='echo -n (pwd) | pbcopy'
alias c="nvim -c 'CommandTRipgrep'"
alias n="nvim"
alias nv="nvim ."
# alias nn="nvim -c 'cd ~/.config/nvim' -c 'CommandTRipgrep'"
alias nn="nvim -c 'cd ~/.config/nvim' -c 'Telescope find_files'"
alias h="hx"
alias st="subl"
alias sm="smerge"
alias code="code -r"
alias lg="lazygit"
alias nnn="nnn -e"
alias r="ranger"
alias rd="ranger ~/Downloads"
alias yo="open -a yoink"
alias marta="marta --existing-tab"
alias we="fish_greeting"
alias t="~/dotfiles/scripts/t"
alias tt="~/dotfiles/scripts/tt"
alias T="~/dotfiles/scripts/T.sh"
alias TT="~/dotfiles/scripts/TT.sh"
alias lfl="lf '$(head -n 1 ~/.cache/lf/last_dir)'"
alias td="todos_rg"
alias tf="todos_rg fzf"
alias ec="emacsclient -nc"
alias app="pwd >> ~/projects-dirs"
alias acp="pwd >> ~/confs-dirs"
alias awp="pwd >> ~/work-dirs"
alias osp="presenterm ~/pCloud/Notes-Database/00-Inbox/scratch_present.md"
alias j="joshuto"
alias y="yazi --cwd-file ~/.cache/yazi/last_dir"
alias s='sesh connect (sesh list -i | fzf --ansi --height "50%" --border-label "Pick a Sesh" --prompt="⚡ ")'

function lt
    if test (count $argv) -gt 0
        eza --icons -a --tree --level=$argv[1] -I "node_modules|.git"
    else
        # use lta alias above to print all levels
        eza --icons -a --tree --level=3 -I "node_modules|.git"
    end
end

function llt
    if test (count $argv) -gt 0
        eza --icons -al --tree --level=$argv[1] -I "node_modules|.git"
    else
        eza --icons -al --tree --level=3 -I "node_modules|.git"
    end
end

#: }}}

#: Vi mode {{{

# # Vi mode cursor shape
# Set the normal and visual mode cursors to a block
# set fish_cursor_default block
# Set the insert mode cursor to a line
# set fish_cursor_insert line
# Set the replace mode cursor to an underscore
# set fish_cursor_replace_one underscore
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual block

# Function to change cursor on mode switch
function fish_vi_cursor --on-variable fish_bind_mode
    switch $fish_bind_mode
        case default
            echo -en "\e[2 q" # Set block cursor
            set fish_cursor_custom block blink
        case insert
            echo -en "\e[6 q" # Set line cursor
            set fish_cursor_custom line blink
        case visual
            echo -en "\e[2 q" # Set block cursor
            set fish_cursor_custom block
    end
end

#: }}}

#: Add homebrew's python3 and pip3 as default {{{

# Add homebrew's python3 and pip3 as default (so no need to add the 3 at the end)
# set -gx PATH $(brew --prefix)/opt/python@3.12/libexec/bin $PATH

#: }}}

#: Fzf {{{

set -gx PATH $PATH $(brew --prefix)/opt/fzf/bin
setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
# setenv FZF_DEFAULT_OPTS "--height 20% --color 'gutter:-1' --preview-window right:50% --bind ctrl-l:toggle-preview"
# alternative pointer ''
# setenv FZF_DEFAULT_OPTS "--reverse --history='$HOME/.fzf_history' --border rounded --no-info --prompt='  ' --pointer='' --marker=' ' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:5,hl+:5,header:2,separator:0,info:4,label:4,pointer:5,prompt:#828BB8,query:#828BB8"
# setenv FZF_DEFAULT_OPTS "--reverse --history='$HOME/.fzf_history' --border rounded --no-info --prompt='  ' --pointer='' --marker=' ' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:5,hl+:5,header:2,separator:5,info:4,label:4,pointer:5,prompt:#828BB8,query:#828BB8"
set -gx FZF_DEFAULT_OPTS "--reverse --history=$HOME/.fzf_history --border rounded --height 100% --info=right --prompt='  ' --pointer='•' --marker=' ' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:#FF87D7,hl+:#FF87D7,header:2,separator:#FF87D7,info:4,label:4,pointer:#FF87D7,prompt:#828BB8,query:#828BB8 --info-command='echo \"\$FZF_INFO (\$(set_color -o yellow)\$FZF_POS\$(set_color normal)) 💛\"'"

#: }}}

#: add ~/bin to path {{{

set -gx PATH $PATH $HOME/bin

#: }}}

#: Golang's path {{{

set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

#: }}}

#: Lua {{{
# set -gx PATH /opt/homebrew/Cellar/lua@5.1/5.1.5_8/bin $PATH
#: }}}

#: Postgres {{{

# Postgres
set -gx PATH $PATH /Applications/Postgres.app/Contents/Versions/14/bin

#: }}}

#: Rust's cargo {{{

set -gx PATH $HOME/.cargo/bin $PATH

#: }}}

#: Autojump {{{

[ -f $(brew --prefix)/share/autojump/autojump.fish ]; and source $(brew --prefix)/share/autojump/autojump.fish

#: }}}

#: ZK Notes {{{

set -gx ZK_NOTEBOOK_DIR "$HOME/pCloud/Notes-zk"
set -gx ZK_SHELL "/bin/bash"

#: }}}

#: Alogorithms course Java class {{{

set -gx CLASSPATH $HOME/Dev/Java-Libraries/algs4.jar

#: }}}

#: Fish git prompt {{{

set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"
set __fish_git_prompt_char_stateseparator ' '

#: }}}

#: colored man output {{{

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

#: }}}

#: Prompt configuration {{{

# Prompt configuration
# function fish_prompt
#   echo
#   set -g fish_prompt_pwd_dir_length 1
#   set -g fish_prompt_pwd_full_dirs 2 
#   set_color white
#   # echo -n "["(date "+%H:%M")"] "
#   # echo -n '卑 '
#   # set_color blue
#   # set_color yellow
#   # set_color white
#   set_color magenta
#   # echo -n (prompt_pwd)
#   if [ $PWD != $HOME ]
#     if [ (dirname $PWD) = $HOME ]
#       echo -n "~/"(basename $PWD)
#     else if [ (dirname $PWD) = "/" ]
#       echo -n $PWD
#     else
#       echo -n (__shorten (basename (dirname $PWD)))/(basename $PWD)
#     end
#   else
#     echo -n (prompt_pwd)
#     # echo -n "~"
#   end
#   set_color normal
#   printf '%s' (__fish_git_prompt)
#   # set_color brblack
#   echo
#   set_color white
#   # set_color red
#   # echo -n ' ❯ '
#   echo -n '❯ '
#   # echo -n '▲ '
#   # echo -n '△ '
#   # echo -n '喝 '
#   # echo -n '➜ '
#   set_color normal
# end

# function fish_right_prompt -d "Right Prompt"
#   set_color normal
#   printf '%s ' (__fish_git_prompt)
# end

#: }}}

#: fish - interactive status {{{

if status is-interactive
    # Commands to run in interactive sessions can go here
end

#: }}}

#: fish_greeting function {{{

function fish_greeting
    set r (random 0 100)

    if test $r -lt 90
        todos_rg
    end
end

#: }}}

#: Add zoxide {{{

zoxide init fish | source

#: }}}

#: Add starship prompt {{{

starship init fish | source
enable_transience

#: }}}

# Setting PATH for Python 3.12
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# eval "$(luarocks path --bin)" # you can also add LUA_PATH based on your own setup
set -gx DYLD_LIBRARY_PATH /opt/homebrew/Cellar/imagemagick/7.1.1-28/lib # check your imagemagic installation path; this resolve dyld loading failure
