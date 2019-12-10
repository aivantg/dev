#!/usr/bin/env bash

dev-config-edit() {
  nano $DEV_CONFIG_PATH/dev.sh
}

dev-config-update() {
  source $DEV_CONFIG_PATH/dev.sh
}

dev-config-develop() {
  code -a $DEV_CONFIG_PATH
}
