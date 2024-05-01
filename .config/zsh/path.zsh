# Setup PATH

export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/bin:$HOME/.fzf/bin"

#: Add Brew to path {{{
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
# Add homebrew's python3 and pip3 as default (so no need to add the 3 at the end)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/usr/local/opt/python@3.12/libexec/bin:$PATH
  export PATH=/opt/homebrew/opt/python@3.12/libexec/bin:$PATH
fi
#: }}}

# add llvm to path for clangd (LSP for c/c++)
if [ -d "/usr/local/opt/llvm/bin/" ] ;
then export PATH="/usr/local/opt/llvm/bin/:$PATH"
fi

# home folder bin path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/shims:$PATH"

export PATH=$GIT_HOME:$PATH
export PATH="$PATH:/Users/Yusuf/bin:/Library/TeX/Distributions/Programs/texbin/"

# for GO programmming
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

# for Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Deno bin Path
export PATH="/Users/ivan/.deno/bin:$PATH"

