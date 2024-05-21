# Eval apps

# FZF
# Use one of the following:
# eval "$(fzf --zsh)"
zvm_after_init_commands+=('eval "$(fzf --zsh)"')
# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# RVM
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# source $HOME/.rvm/scripts/rvm

# Starship
# eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# imagemagic
# eval "$(luarocks path --bin)" # you can also add LUA_PATH based on your own setup
# export DYLD_LIBRARY_PATH=/opt/homebrew/Cellar/imagemagick/7.1.1-32/lib # check your imagemagic installation path; this resolve dyld loading failure
