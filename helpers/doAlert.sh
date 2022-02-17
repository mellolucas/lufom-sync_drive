#!/bin/bash

[[ -f "/usr/share/sounds/speech-dispatcher/trumpet-12.wav" ]] &&
  doAlert () {
    aplay /usr/share/sounds/speech-dispatcher/trumpet-12.wav 2> /dev/null
  } ||
  doAlert () {
    printf '\7'; sleep 0.2; printf '\a'; sleep 0.2; tput bel 2> /dev/null
  }
export -f doAlert
