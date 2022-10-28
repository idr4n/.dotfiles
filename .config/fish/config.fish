# Fish shell config

# Greeting
# set -U fish_greeting only once in the command line or,
set -g fish_greeting

# Set EDITOR
set -gx EDITOR nvim

# nnn env variables
# bookmarks
set -gx NNN_BMS "b:~/Sync/Books;d:~/Downloads;p:~/Sync/PSU;q:~/Sync/PSU/Econ103/Econ103-2021-II;w:~/Sync/PSU/Econ207/Econ207-2021-II;c:~/.config;v:/Volumes"
# plugins
set -gx NNN_PLUG "d:dropover;f:openfinder;j:autojump;c:fcd;h:fhcd;o:fzopen;l:openzathura;p:timg-preview;t:preview-tabbed;T:trash;v:imgview;z:fzcd;y:yoink;a:timg-preview-all"
# colors
set -gx NNN_FCOLORS "c1e28D31006033f7c6d6abc4"
# terminal
set -gx TERMINAL $(echo $(which alacritty))
set -gx NNN_USE_EDITOR 1

# Bat env variable
set t (math (date +%H) + (date +%M)/60)
if [ $t -gt 8 ]
  and [ $t -lt 18 ]
  # set -gx BAT_THEME "gruvbox-light"
  set -gx BAT_THEME "Nord"
else
  set -gx BAT_THEME "Nord"
end


# Aliases
alias ls='exa --icons'
alias ll='ls -al'
alias la='ls -a'
alias lt='ls --tree --level=3 -I node_modules'
alias llt='ll --tree --level=3 -I node_modules'
alias c='clear'
alias cdd='cd ~/Dropbox'
alias cdp='cd ~/pCloud'
alias pd='pwd'
alias up='cd ..'
alias tm='tmux'
alias tw='tmux new-session -A -s W'
alias tc='tmux new-session -A -s C'
alias xc='pwd | pbcopy'
alias n="nvim"
alias c="nvim ."
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
alias zf="zk f"
alias zl="zk l"
alias zd="zk d"
alias zs="zk s"
alias lfl="lf '$(head -n 1 ~/.cache/lf/last_dir)'"

# # Vi mode cursor shape
# Set the normal and visual mode cursors to a block
# set fish_cursor_default block
# Set the insert mode cursor to a line
# set fish_cursor_insert line
# Set the replace mode cursor to an underscore
# set fish_cursor_replace_one underscore

# Add homebrew's python3 and pip3 as default (so no need to add the 3 at the end)
set -gx PATH $(brew --prefix)/opt/python@3.10/libexec/bin $PATH

# Fzf
set -gx PATH $PATH $(brew --prefix)/opt/fzf/bin
setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS "--height 20% --color 'gutter:-1' --preview-window right:50% --bind ctrl-l:toggle-preview"

# add ~/bin to path
set -gx PATH $PATH $HOME/bin

# Golang's path
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# Postgres
set -gx PATH $PATH /Applications/Postgres.app/Contents/Versions/14/bin

# Rust's cargo
set -gx PATH $HOME/.cargo/bin $PATH

# Autojump
[ -f $(brew --prefix)/share/autojump/autojump.fish ]; and source $(brew --prefix)/share/autojump/autojump.fish

# ZK Notes
set -gx ZK_NOTEBOOK_DIR "$HOME/Sync/Notes-zk"
set -gx ZK_SHELL "/bin/bash"

# MegaSync
set -gx PATH /Applications/MEGAcmd.app/Contents/MacOS $PATH

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"
set __fish_git_prompt_char_stateseparator ' '

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

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

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
	set r (random 0 100)
  # set r 10

  if test -s ~/Sync/Notes-Database/todos_unimportant.md
    or test -s ~/Sync/Notes-Database/todos_eventually.md
    or test -s ~/Sync/Notes-Database/todos_upcoming.md
    or test -s ~/Sync/Notes-Database/todos_important.md
    set_color normal
    echo -en " \e[1mTODOs\e[0;32m "
    if [ $r -gt 10 ] 
      and test -s ~/Sync/Notes-Database/todos_unimportant.md
      set_color --bold green
      echo -n "+"
    end
    if [ $r -gt 20 ] 
      and test -s ~/Sync/Notes-Database/todos_eventually.md
      set_color --bold blue
      echo -n "+"
    end
    if [ $r -gt 50 ] 
      and test -s ~/Sync/Notes-Database/todos_upcoming.md
      set_color --bold yellow
      echo -n "+"
    end
    set_color normal
    echo
  end

	if [ $r -lt 10 ]
		# unimportant, so show rarely
    set_color green
    if test -s ~/Sync/Notes-Database/todos_unimportant.md
      echo
      cat ~/Sync/Notes-Database/todos_unimportant.md | sed 's/^/  /'
    end
		# echo "  [project] <description>"
	end
	if [ $r -lt 20 ]
		# not so important, so show occasionally
    set_color blue
    if test -s ~/Sync/Notes-Database/todos_eventually.md
      echo
      cat ~/Sync/Notes-Database/todos_eventually.md | sed 's/^/  /'
    end
		# echo "  [project] <description>"
	end
	if [ $r -lt 50 ]
		# upcoming, so prompt regularly
		set_color yellow
    if test -s ~/Sync/Notes-Database/todos_upcoming.md
      echo
      cat ~/Sync/Notes-Database/todos_upcoming.md | sed 's/^/  /'
    end
		# echo "  [project] <description>"
	end

	# urgent, so prompt always
  set_color magenta
  if test -s ~/Sync/Notes-Database/todos_important.md
    echo
    cat ~/Sync/Notes-Database/todos_important.md | sed 's/^/  /'
  end
	# echo "  [project] <description>"

	if test -s ~/Sync/Notes-Database/notes.md
    echo
    set_color normal
    echo -e " \e[1mNOTEs\e[0;32m"
    echo
		set_color brblue
		cat ~/Sync/Notes-Database/notes.md | sed 's/^/  /'
	end

  # echo
	set_color normal
end

# Add zoxide
zoxide init fish | source

# Add starship prompt
starship init fish | source
