# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export ZSH=$HOME/.oh-my-zsh
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting git-prompt zsh-vi-mode colored-man-pages)
# source $ZSH/oh-my-zsh.sh

# Setup Path
source $ZDOTDIR/path.zsh

# We may need to manually set the language environment
export LANG=en_US.UTF-8

#: XDG_CONFIG_HOME {{{
export XDG_CONFIG_HOME=$HOME/.config
#: }}}

# zsh-vi-mode
# source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# bindkey jk vi-cmd-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

#: Set Editor {{{
export VISUAL=nvim
export EDITOR="$VISUAL"
#: }}}

# Setup (completion, history, exports, eval apps, etc.)
source $ZDOTDIR/setup.zsh

# Aliases
source $ZDOTDIR/alias.zsh

# source functions
source $ZDOTDIR/functions.zsh

# Load (eval) apps
source $ZDOTDIR/apps.zsh

# Zinit hash definitions
declare -A ZINIT  # initial Zinit's hash definition, if configuring before loading Zinit, and then:
ZINIT[NO_ALIASES]=1

# #: Zinit {{{
#
# ### Added by Zinit's installer
#
# if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
#   print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
#   command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
#   command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
#     print -P "%F{33} %F{34}Installation successful.%f%b" || \
#     print -P "%F{160} The clone has failed.%f%b"
# fi
#
# source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
#
# # Load a few important annexes, without Turbo
# # (this is currently required for annexes)
# zinit light-mode for \
#   zdharma-continuum/zinit-annex-as-monitor \
#   zdharma-continuum/zinit-annex-bin-gem-node \
#   zdharma-continuum/zinit-annex-patch-dl \
#   zdharma-continuum/zinit-annex-rust
#
# ### End of Zinit's installer chunk
#
#
# # Plugins
#
# zinit for \
#     light-mode \
#   zdharma-continuum/fast-syntax-highlighting \
#
# zinit lucid wait"1" for \
#     light-mode \
#   zsh-users/zsh-autosuggestions \
#   zsh-users/zsh-completions
#
#
# zinit lucid wait for \
#     light-mode \
#   unixorn/fzf-zsh-plugin
#
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode
#
# zinit ice depth=1
# zinit light romkatv/powerlevel10k
#
# #: }}}


#: zimfw {{{

ZIM_HOME=$ZDOTDIR/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

#: }}}


#: Prompt {{{

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

#: }}}
