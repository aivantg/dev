#!/usr/bin/env bash

dev-ssh-pub() {
  cat $HOME/.ssh/id_rsa.pub | pbcopy
  echo "Copied SSH Public key To Clipboard!"
}

dev-ssh-edit() {
  nano ~/.ssh/config
}
