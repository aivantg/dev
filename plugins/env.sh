#!/usr/bin/env bash

dev-env-set() {
  VARNAME=$1
  local VALUE="${!VARNAME}"
  if [[ ! -z "$VALUE" ]]; then
    echo "Warning, variable ${VARNAME} already has value: ${!VARNAME} !"
    echo "Skipping...Please Fix!"
  else
    echo "$1,$2" >> "$DEV_CONFIG_PATH/env.txt"
    setup-env
  fi
}

dev-env-setf() {
  echo "$1,$2" >> "$DEV_CONFIG_PATH/env.txt"
  setup-env
}


dev-env-rm() {
  echostring="Dev Env Variables Removed:"
  while IFS=, read -r -a array
  do
    if [ "${array[0]}" != "$1" ]; then
      echo "${array[0]},${array[1]}"
    else
      echostring="$echostring\n${array[0]} --> ${array[1]}"
    fi

  done < $DEV_CONFIG_PATH/env.txt > $DEV_CONFIG_PATH/temp_env.txt
  mv $DEV_CONFIG_PATH/temp_env.txt $DEV_CONFIG_PATH/env.txt
  if [ "$echostring" != "Dev Env Variables Removed:" ]; then
    echo -e "$echostring"
    export $1=""
  else
    echo -e "No dev environment variables found matching pattern: '$1'"
  fi
}

dev-env-ls() {
  echo -e "\n---Current Dev Environemnt Variables---\n"
  while IFS=, read -r -a array
  do
    echo "${array[0]} --> ${array[1]} "
  done < "$DEV_CONFIG_PATH/env.txt"
  echo -e "\nAdd more with 'dev env:set <name> <value>'\nRemove with 'dev env:rm <name>'\n"
}
