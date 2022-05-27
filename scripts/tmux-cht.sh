#!/usr/bin/env sh

commands=(grep ls sed awk cp rm mv rg \kill man)

langs=(
  bash
  cpp
  css
  golang
  html
  javascript
  lua
  python
  rust
  scss
  tmux
  typescript
  react
)

opts=("${langs[@]}" "${commands[@]}")
selection=`printf "%s\n" "${opts[@]}" | sort -d | fzf --layout=reverse --height 50% --ansi --bind=enter:replace-query+print-query`

[[ -z $selection ]] && echo 'nothing selected!' && exit

read -p "Enter Query: " query


if [[ " ${commands[*]} " =~ " ${selection} " ]]; then
  tmux neww bash -c "echo \"curl cht.sh/$selection~$query\" & curl cht.sh/$selection~$query & while [ : ]; do sleep 1;done"
  # tmux neww bash -c "curl -s cht.sh/$selection~$query | less -R"
else
  query=`echo $query | tr ' ' '+'`
  tmux neww bash -c "echo \"curl cht.sh/$selection/$query\" & curl cht.sh/$selection/$query & while [ : ]; do sleep 1;done"
  # tmux neww bash -c "curl -s cht.sh/$selection/$query | less -R"
fi
