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
# export NVIM_APPNAME=LazyVim
# export NVIM_APPNAME=NvChad
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
fpath+=${ZDOTDIR:-~}/.zsh_functions
