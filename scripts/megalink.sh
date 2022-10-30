#!/usr/bin/env bash

[ -z "$1" ] && echo "No file/folder given." && exit 1;

[ ! -f "$1" ] && [ ! -d "$1" ] && echo "Not a valid path." && exit 1;

flag="-a"

if [ "$2" == "-d" ]; then
    flag="-d"
fi

absolute_path=$HOME/Sync
relative_path=$(grealpath --relative-to="$absolute_path" "$1")

path="Sync/${relative_path}"
export=$(mega-export $flag "$path")
link=$(echo "$export" | egrep -o "https?://[^ )>]+")

echo $export

if [ -z "$link" ]; then
    echo "No link" | pbcopy
else
    echo "$link" | pbcopy
fi
