#: Nvim config switcher {{{
alias l="NVIM_APPNAME=LazyVim nvim"
alias a="NVIM_APPNAME=AstroNvim nvim"
alias v="NVIM_APPNAME=NvChad nvim"
alias lk="NVIM_APPNAME=LazyKick nvim"
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
# alias c="nvim -c 'lua require(\"bufferline\")' -c 'CommandTRipgrep'"
alias c="nvim -c 'lua require(\"bufferline\")' -c 'lua require(\"telescope.builtin\").find_files(_G.dropdown_theme())'"
alias n="nvim"
alias nv="nvim ."
# alias nn="nvim -c 'cd ~/.config/nvim' -c 'lua require(\"bufferline\")' -c 'CommandTRipgrep'"
alias nn="nvim -c 'cd ~/.config/nvim' -c 'lua require(\"bufferline\")' -c 'lua require(\"telescope.builtin\").find_files(_G.dropdown_theme())'"
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

