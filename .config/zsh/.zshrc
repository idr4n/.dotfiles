# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="myown"
# ZSH_THEME="gnzh"
# ZSH_THEME="Predawn"
# ZSH_THEME="cobalt2"
# ZSH_THEME="spaceship"
# ZSH_THEME="zeit"
# ZSH_THEME="robbyrussell"
ZSH_THEME="yusufs"
# SPACESHIP_DIR_SHOW=true
# SPACESHIP_PROMPT_SYMBOL="▲"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting git-prompt zsh-vi-mode colored-man-pages)

# User configuration

export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/bin:$HOME/.fzf/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# add llvm to path for clangd (LSP for c/c++)
if [ -d "/usr/local/opt/llvm/bin/" ] ;
then export PATH="/usr/local/opt/llvm/bin/:$PATH"
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Make neovim the default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# some more aliases
alias ls='exa --icons'
alias ll='ls -al'
alias la='ls -a'
alias llg='ls -al --grid'
alias lli='ls -al --git'
alias lt='ls --tree --level=3'
alias llt='ll --tree --level=3'
alias c='clear'
alias cdd='cd ~/Dropbox'
alias cdp='cd ~/pCloud'
alias pd='pwd'
alias up='cd ..'
# alias tmux='tmux -2'
alias tm='tmux'
alias tw='tmux new-session -A -s W'
alias tc='tmux new-session -A -s C'
alias xc='pwd | xsel -b'
alias xv='xsel -b'
alias octavet='octave --no-gui'
alias nv="nvim"
alias st="subl"
alias sm="smerge"
alias cds="cs /Users/Yusuf/Library/Application\ Support/Sublime\ Text\ 3/Packages/"
alias emc="emacsclient -n"
alias rstudio='open -a Rstudio'
alias mk="open -a 'Marked 2'"
alias code="code -r"
alias coin="code-insiders -r"
alias lg="lazygit"
# alias n="nnn -e"
alias nd="nnn -e ~/Downloads"
alias r="ranger"
alias rd="ranger ~/Downloads"
alias yo="open -a yoink"
alias marta="marta --existing-tab"

# Fucntion to find directory with fzf
function cdf () {
    # cd "$(find * -type d | fzf)"
    cd "$(fd -t d | fzf)"
}

# Fuction to run ls after cd
function cs () {
    cd "$@" && ls
}
# Fuction to run la after cd
function ca () {
    cd "$@" && la
}
# Fuction to cd into just created dir
function mkcd () {
    mkdir -p "$1" && cd "$1"
}
# Function to create file and together with path recursively.
function mkf () {
    DIR=$(dirname "$1")
    FILE=$(basename "$1")
    mkcd "${DIR}" && touch "${FILE}" 
}

# home folder bin path
export PATH="$HOME/bin:$PATH"

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-default-dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# vi mode
# set -o vi
# bindkey -v
# bindkey jk vi-cmd-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/shims:$PATH"

export PATH=$GIT_HOME:$PATH
export PATH="$PATH:/Users/Yusuf/bin:/Library/TeX/Distributions/Programs/texbin/"

# for GO programmming
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

# for Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Include Z, yo
# if [[ "$OSTYPE" == "darwin"* ]]; then
#     . /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
# fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval $(/usr/libexec/path_helper -s)
fi

# NOTE: Zsh syntax highlighting like in Fish (Keep this last)
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zprezto
# source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

export FZF_DEFAULT_OPTS="--color 'gutter:-1'"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always --line-range :30 {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -30'"

# Add brew to path
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
# Add homebrew's python3 and pip3 as default (so no need to add the 3 at the end)
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=/usr/local/opt/python@3.10/libexec/bin:$PATH
    export PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# source $HOME/.rvm/scripts/rvm

# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# Deno bin Path
export PATH="/Users/ivan/.deno/bin:$PATH"

# Starship
eval "$(starship init zsh)"

# Add SSH keys (needed for gitui)
ssh-add -A &> /dev/null

# Kakoune default shell
# export KAKOUNE_POSIX_SHELL=/bin/dash

# ZK Notebook dir
export ZK_NOTEBOOK_DIR="$HOME/Dropbox/Notes-zk"

# source other functions
source ~/.config/zsh/functions.sh

# source nnn config
source ~/.config/zsh/nnn.sh
