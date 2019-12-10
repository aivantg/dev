#!/usr/bin/env bash

dev-profile-code() {
  code $HOME/.bash_profile
}

dev-profile-edit() {
  nano $HOME/.bash_profile
}

dev-profile-update() {
  source $HOME/.bash_profile
}
