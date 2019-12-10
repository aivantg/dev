#!/usr/bin/env bash

dev-profile-atom() {
  atom $HOME/.bash_profile
}

dev-profile-edit() {
  nano $HOME/.bash_profile
}

dev-profile-update() {
  source $HOME/.bash_profile
}
