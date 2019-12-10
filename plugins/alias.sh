#!/usr/bin/env bash

dev-alias-mk() {
  echo "$1,$2" >> "$DEV_CONFIG_PATH/project_aliases.txt"
  source "$DEV_CONFIG_PATH/dev-completion.sh"
}

dev-alias-ls() {
  echo -e "\n---Current Aliases---\n"
  while IFS=, read -r -a array
  do
    echo "${array[0]} --> ${array[1]} "
  done < "$DEV_CONFIG_PATH/project_aliases.txt"
  echo -e "\nAdd more with 'dev alias:mk <alias> <path>'\nRemove with 'dev alias:rm <alias>'\n"
}

dev-alias-rm() {
  echostring="Aliases Removed:"
  while IFS=, read -r -a array
  do
    if [ "${array[0]}" != "$1" ]; then
      echo "${array[0]},${array[1]}"
    else
      echostring="$echostring\n${array[0]} --> ${array[1]}"
    fi

  done < $DEV_CONFIG_PATH/project_aliases.txt > $DEV_CONFIG_PATH/temp_p_aliases.txt
  mv $DEV_CONFIG_PATH/temp_p_aliases.txt $DEV_CONFIG_PATH/project_aliases.txt
  if [ "$echostring" != "Aliases Removed:" ]; then
    echo -e "$echostring"
  else
    echo -e "No aliases found matching pattern: '$1'"
  fi
  source "$DEV_CONFIG_PATH/dev-completion.sh"
}

dev-alias-cd() {
  declare -A PROJALIASES
  while IFS=, read -r alias value
  do
    PROJALIASES[$alias]=$value
  done < "$DEV_CONFIG_PATH/project_aliases.txt"

  PROJSTRING="$DEV_FOLDER_PATH"
  for PARAM in "$@"
  do

    if [[ $PARAM == *-d* ]]; then
      continue
    fi

    if [[ $PARAM == *-o* ]]; then
      continue
    fi

    FOLDER=${PROJALIASES[$PARAM]}
    if [ "$FOLDER" = "" ]; then
      CHECKINGPREFIXES=false
      PROJSTRING="$PROJSTRING/$PARAM"
    else
      PROJSTRING="$PROJSTRING/$FOLDER"
    fi
  done
  cd $PROJSTRING
  if [[ $* == *-d* ]]; then
    code -a .
  fi

  if [[ $* == *-o* ]]; then
    open .
  fi
}
