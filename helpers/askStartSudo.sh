#!/bin/bash
askStartSudo () {
# Notify the use of sudo ----------
echo -e "\e[1;96mThis script is about to start!"
sleep 1
echo -e "You may soon be asked for your password in order to proceed."
sleep 1
doAlert
while true; do
  echo -e "\e[1;96m"
  read -p "Do you wish to proceed? (Y/n)" yn
  echo
  case $yn in
    [Y]* )
      echo -e "\e[1;96mStarting script execution...\e[0m"
      break;;
    [Nn]* )
      echo -e "\e[1;96mAborting script execution!"
      echo -e "----------------------------------------\e[0m"
      exit 0 ;;
    * )
      echo
      echo -e "\e[1;96mPlease \e[1;91manswer 'y' (yes) or 'n' (no). \e[0m";;
  esac
  unset yn
  echo
  echo
done
echo
}

export -f askStartSudo
