#!/bin/bash

findRemoteDrive() {
  input_remote=$1
  if [[ ! -z $input_remote ]]
  then
    if [[ $(rclone listremotes | egrep $(echo "^${input_remote}\:?$") | wc -l) > 0 ]] ; then
      remote=$(rclone listremotes | egrep $(echo "^${input_remote}\:?$"))
    else
      doAlert
      echo "The argument passed in doesn't match any of the existing remote drives."
      echo "Please: choose one from the list below write it as an argument to this"
      echo "script; or set up a new remote using the 'rclone config' command."
      rclone listremotes
      exit 0
    fi
  elif [[ $( rclone listremotes | wc -l ) == 1 ]]
  then
    remote=$(rclone listremotes)
  elif [[ $( rclone listremotes | wc -l ) == 0 ]]
  then
    doAlert
    echo "There are no remote drives configured. Run 'rclone config' set up one."
    exit 0
  elif [[ $( rclone listremotes | wc -l ) > 1 ]]
  then
    doAlert
    echo "There are more than one remote drive available. Pass the name of the"
    echo "desired one as an argument to this script, choosing from the list below:"
    rclone listremotes
    exit 0
  fi
}

export -f findRemoteDrive
