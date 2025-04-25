#!/usr/bin/env bash

dir=$(sed -n ${1}p ~/harpoon-dirs)

open $dir
# marta --existing-tab $dir
