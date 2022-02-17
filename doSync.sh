#!/bin/sh

echo
echo -e "\e[36m<---------------------------------- START -------------------------------->\e[0m"
echo -e "\e[36m<------------------------- Remote Drive Sync Script ---------------------->\e[0m"
echo
echo

# TODO: Add config step and 'check if configured' before starting anything In daemon, abort if not config or no rclone installed
# Add backup for both at every operation. 5 to 15 backups may do. Zip them instead of storing one more directory.

# Set Options --------------------
input_remote=$1
name_remote_dir="Commonplace/"
path_local_dir="/home/lufom/my-commonplace/"

# Set paths --------------------
path_script=$PWD/$(basename $0)
path_pwd=$PWD
path_assets=$path_pwd/assets
path_src=$path_pwd/src
path_helpers=$path_pwd/helpers

# Source helpers --------------------
for helper in ${path_helpers}/*.sh; do
  source "$helper"
done

# Check if is interctive and run the proper script
if [ -t 0 ]; then
  echo "Interactive Session Detected!"
  sleep 2
  session_interactive=1
  source ${path_src}/runSyncInteractive.sh
else
  exit 0 # TODO: create this after setting backup by default and, ideally, logs
  session_interactive=0
  source ${path_src}/runSyncDaemon.sh
fi

echo
echo
echo -e "\e[2;36m<------------------------ /Remote Drive Sync Script ---------------------->\e[0m"
echo -e "\e[2;36m<---------------------------------- /END --------------------------------->\e[0m"
echo
