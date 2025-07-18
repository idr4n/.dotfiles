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
if test $t -gt 7; and test $t -lt 19
    set -gx BAT_THEME "gruvbox-light"
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

#: Ripgrep {{{
set -gx RIPGREP_CONFIG_PATH $HOME/.rgrc
#: }}}

#: EZA {{{
set -gx EZA_CONFIG_DIR $HOME/.config/eza
#: }}}

#: Abbreviations {{{
abbr -a lr --set-cursor "eza --icons -la | rg '%'"
abbr -a \*\* --position anywhere --set-cursor "(fd . --type f -H -E '*.git*' -E '*node_modules*' | fzf --print-query | tail -1)"
abbr -a gc --set-cursor "git checkout"
abbr -a wp --set-cursor "set -l path (which %); echo \$path; echo -n \$path | pbcopy"
abbr -a yc --set-cursor "ys -c '%'"
abbr -a yfc --set-cursor "ys --fetch % -c 'summarize this for me'"
abbr -a yfa --set-cursor "ys --fetch % -a 'summarize this for me'"
abbr -a yrc --set-cursor "ys --rag -c '%'"
abbr -a yra --set-cursor "ys --rag -a '%'"
abbr -a ysa --set-cursor "ys --ask '%'"
abbr -a zt --set-cursor "zk edit -Me --match=\"[ ]\" --match=\"%\" --tag \"\" -i"
#: }}}

#: Aliases {{{
# alias ls='lsd'
alias lb='br -dp'
alias ls='eza --icons'
alias ll='ls -al'
alias la='ls -a'
alias lta='la --tree -I node_modules -I .git'
alias tree='la --tree -I node_modules -I .git'
alias oo='cd ~/dotfiles'
alias oc='cd ~/.config'
alias on='cd ~/.config/nvim'
alias og='cd ~/.config/ghostty'
alias ow='cd ~/.config/wezterm'
alias oz="cd ~/pCloud/Notes-zk"
alias od="cd ~/pCloud/Notes-Database"
alias pd='pwd'
alias up='cd ..'
alias tm='tmux'
alias ts='~/dotfiles/scripts/TT.sh'
alias tw='ts Work'
alias tc='ts Config'
alias tl='ts Dev'
alias pc='echo -n "\""(pwd)"\"" | pbcopy'
alias pc2='echo -n (pwd | string replace -a " " "\\ ") | pbcopy'
alias c="nvim -c 'CommandTRipgrep'"
alias n="nvim"
alias nv="nvim ."
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
alias td="todos_rg glow"
alias tf="todos_rg fzf"
alias ec="emacsclient -nc"
alias app="pwd >> ~/projects-dirs"
alias acp="pwd >> ~/confs-dirs"
alias awp="pwd >> ~/work-dirs"
alias osp="presenterm ~/pCloud/Notes-zk/notes/scratch_present.md"
alias y="yazi --cwd-file ~/.cache/yazi/last_dir"
alias s='sesh connect (sesh list -i | fzf --ansi --height "50%" --border-label "Pick a Sesh" --prompt="⚡ ")'
alias ys="youtube-summarizer"
alias ysh="youtube-summarizer --history"
alias ysf="youtube-summarizer --first"
alias ysl="youtube-summarizer --last"
alias yse="youtube-summarizer -e"
alias ysi="youtube-summarizer -i"
alias yi="youtube-summarizer -I"
alias i="zi"
alias no="naas"
alias ct="crypto-tracker"
alias b="broot"
alias gst="git status"
alias gcl="git clone"

function lt
    if test (count $argv) -gt 0
        # eza --icons -a --tree --level=$argv[1] -I "node_modules|.git"
        eza -lTag --level=$argv[1] --icons=always -I "node_modules|.git"
    else
        # use lta alias above to print all levels
        # eza --icons -a --tree --level=3 -I "node_modules|.git"
        eza -lTag --level=3 --icons=always -I "node_modules|.git"
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
set fish_cursor_default block
set fish_cursor_insert line
# set fish_cursor_insert block
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# # Function to change cursor on mode switch
function fish_vim_cursor --on-variable fish_bind_mode
    switch $fish_bind_mode
        case default
            echo -en "\e[2 q" # Set block cursor
            set fish_cursor_custom block
        case insert
            echo -en "\e[6 q" # Set line cursor
            set fish_cursor_custom line
        case visual
            echo -en "\e[2 q" # Set block cursor
            set fish_cursor_custom block
    end
end

# Activate vi keybindings
set -g fish_key_bindings fish_vi_key_bindings

#: }}}

#: Add homebrew's python3 and pip3 as default {{{

# Add homebrew's python3 and pip3 as default (so no need to add the 3 at the end)
# set -gx PATH $(brew --prefix)/opt/python@3.12/libexec/bin $PATH

#: }}}

#: Fzf {{{

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
set -gx FZF_DEFAULT_OPTS "--reverse --history=$HOME/.fzf_history --border rounded --height 100% --info=right --prompt='  ' --pointer='•' --bind ctrl-l:toggle-preview --color gutter:-1,bg+:-1,fg+:4,hl:#FF87D7,hl+:#FF87D7,header:2,separator:#FF87D7,info:4,label:4,pointer:#FF87D7,prompt:#828BB8,query:#828BB8"

# Set up fzf key bindings
fzf --fish | source

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

#: fish - interactive status {{{

if status is-interactive
    # Commands to run in interactive sessions can go here
end

#: }}}

#: fish_greeting function {{{

function fish_greeting
    set r (random 0 100)
    set r2 (random 0 100)

    if test $r -lt 40
        todos_rg glow
    end

    if test $r2 -lt 5
      naas
    end
end

#: }}}

function fish_title
    # Get shortened path without the full home path
    # basename (prompt_pwd)

    # Get current working directory
    set -l wd (prompt_pwd)

    # Try to get git branch
    set -l git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if test -n "$git_branch"
        echo "$wd ($git_branch)"
    else
        echo $wd
    end
end

#: Add zoxide {{{

zoxide init fish | source

#: }}}

#: Add starship prompt {{{

function starship_transient_prompt_func
  echo -n " 󰦥 at "(set_color yellow)(date "+%H:%M:%S ")(set_color normal)
  # echo -n " $(starship module directory)$(starship module character)"
end

starship init fish | source
enable_transience

#: }}}

#: Helix runtime {{{
set -gx HELIX_RUNTIME $HOME/other_repos/helix/runtime
#: }}}

# Typst
export TYPST_ROOT="$HOME"

# Setting PATH for Python 3.13
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.13/bin" "$PATH"

# Ruby rbenv
if type rbenv >/dev/null
  rbenv init - | source
end
set -gx PATH $PATH "$HOME/.rbenv/shims"

# imagemagick
set -gx DYLD_FALLBACK_LIBRARY_PATH (brew --prefix)/lib $DYLD_FALLBACK_LIBRARY_PATH

