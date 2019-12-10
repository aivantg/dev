#!/usr/bin/env bash
set -o pipefail
export DEV_CONFIG_PATH=${DEV_CONFIG_PATH:=/Users/aivant/Development/.dev}
export DEV_FOLDER_PATH=${DEV_FOLDER_PATH:=/Users/aivant/Development}
source "$DEV_CONFIG_PATH/dev-completion.sh"

## INSTALL PLUGINS
for f in $DEV_CONFIG_PATH/plugins/*.sh; do source $f; done


dev() {
  IFS=':' read -ra PARAMS <<< "$1"
  declare APP="${PARAMS[0]}" CMD="${PARAMS[1]}"
  declare -A apps=( [vbox]=1 [cmd]=1 [env]=1 [server]=1 [app]=1 [ssh]=1 [alias]=1 [config]=1 [profile]=1 ) #Define what apps exist
  if [[ -n $APP && -n "${apps[$APP]}" ]]; then
    shift # Remove first app argument
    if [[ -n "$CMD" ]]; then
      dev-$APP-$CMD $@
    else
      dev-$APP $@
    fi
  else
    dev-alias-cd $@
  fi
}

devp() {
  IFS=':' read -ra PARAMS <<< "$1"
  declare APP="${PARAMS[0]}" CMD="${PARAMS[1]}"
  declare -A apps=( [vbox]=1 [cmd]=1 [env]=1 [server]=1 [app]=1 [ssh]=1 [alias]=1 [config]=1 [profile]=1 ) #Define what apps exist
  if [[ -n $APP && -n "${apps[$APP]}" ]]; then
    shift # Remove first app argument
    if [[ -n "$CMD" ]]; then
      type dev-$APP-$CMD $@
    else
      type dev-$APP $@
    fi
  else
    type dev-alias-cd $@
  fi
}
