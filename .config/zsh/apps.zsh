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

