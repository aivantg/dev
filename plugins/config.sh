#!/usr/bin/env bash

dev-config-edit() {
  nano $DEV_CONFIG_PATH/dev.sh
}

dev-config-update() {
  source $DEV_CONFIG_PATH/dev.sh
}

dev-config-dev() {
  atom -a $DEV_CONFIG_PATH
}

dev-config-plugin() {
  atom $DEV_CONFIG_PATH/plugins/$1.sh
}

dev-config-completion() {
  nano $DEV_CONFIG_PATH/dev-completion.sh
}
