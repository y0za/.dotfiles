#!/bin/bash

: export ${DOTPATH:=~/.dotfiles}

set -eu

match_list() {
  local target=$1
  shift

  for file in $@; do
    if [[ "$target" == "$file" ]]; then
      return 0
    fi
  done
  return 1
}

IGNORE_FILES=('.git' '.gitignore' '.DS_Store')

for dotfile in .??*; do
  if match_list $dotfile ${IGNORE_FILES[@]}; then
    continue
  fi

  echo "ln -fs $DOTPATH/$dotfile ~/$dotfile"
  ln -fs $DOTPATH/$dotfile ~/$dotfile
done
