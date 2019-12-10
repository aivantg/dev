#!/usr/bin/env bash
dev-cmd-ls() {
  echo -e "\n---Current Command Aliases---\n"
  while IFS=, read -r -a array
  do
    echo "${array[0]} --> ${array[1]} "
  done < "$DEV_CONFIG_PATH/cmd_aliases.txt"
  echo -e "\nAdd more with 'dev cmd:mk <name> <cmd>'\nRemove with 'dev cmd:rm <name>'\n"
}

dev-cmd-mk() {
  CMD=$1
  shift
  local VALUE="$(which $CMD)"
  if [[ -n "$VALUE" ]]; then
    echo "Warning, $CMD is already aliased to $(which $CMD)"
    echo "Skipping...Please Fix!"
  else
    echo "$CMD,$@" >> "$DEV_CONFIG_PATH/cmd_aliases.txt"
  fi
  setup-cmd-aliases
}

dev-cmd-mkf() {
  CMD=$1
  shift
  echo "$CMD,$@" >> "$DEV_CONFIG_PATH/cmd_aliases.txt"
  setup-cmd-aliases
}

dev-cmd-rm() {
  echostring="Command Aliases Removed:"
  while IFS=, read -r -a array
  do
    if [ "${array[0]}" != "$1" ]; then
      echo "${array[0]},${array[1]}"
    else
      echostring="$echostring\n${array[0]} --> ${array[1]}"
    fi

  done < $DEV_CONFIG_PATH/cmd_aliases.txt > $DEV_CONFIG_PATH/temp_c_aliases.txt
  mv $DEV_CONFIG_PATH/temp_c_aliases.txt $DEV_CONFIG_PATH/cmd_aliases.txt
  if [ "$echostring" != "Command Aliases Removed:" ]; then
    echo -e "$echostring"
    export $1=
  else
    echo -e "No aliases found matching pattern: '$1'"
  fi
}
