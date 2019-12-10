#!/usr/bin/env bash

setup-cmd-aliases() {
  while IFS=, read -r -a array
  do
    alias ${array[0]}="eval ${array[1]}"
  done < "$DEV_CONFIG_PATH/cmd_aliases.txt"
}

setup-env() {
  while IFS=, read -r -a array
  do
    export "${array[0]}=${array[1]}"
  done < "$DEV_CONFIG_PATH/env.txt"
}

setup-cmd-aliases
setup-env
