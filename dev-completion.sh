#/usr/bin/env bash

ALIASES=""
DEV_FILE_PATH="/Users/aivant/Development/.dev"
while IFS=, read -r -r alias full
do
  ALIASES=("$ALIASES $alias")
done < "$DEV_FILE_PATH/project_aliases.txt"
ALIASES="ssh:pub config:completion profile:edit profile:update app:deploy alias:ls alias:mk alias:cd alias:rm config:edit config:update $ALIASES"
complete -W "$ALIASES" dev
