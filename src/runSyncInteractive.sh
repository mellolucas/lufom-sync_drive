#!/bin/bash

# Alert the user ----------
# Confirm sudo
askStartSudo
echo

# Alert about the premisses adopted
doAlert
echo "The precise directory, local and remote, are predefined within this script"
sleep 1
echo "as ${name_remote_dir} within the directory set as 'bucket' within 'rclone config';"
sleep 1
echo "and ${path_local_dir} as the path to the local target directory."
sleep 2
echo
echo "If any of those presumptions are wrong, immediatly cancel this script, by"
sleep 1
echo "pressing 'ctrl + c' two times, while the mouse pointer is in the terminal's"
sleep 1
echo "command line."
sleep 1
echo
doAlert
echo "If you are ok with the presumptions assumed, press any key to continue."
read -sn1 null
echo
echo "Starting script execution!"
sleep 2

# Execution ----------

# Check if rclone package is installed and updated
sudo dnf install rclone -y

# Find remote
findRemoteDrive $input_remote
echo
sleep 1
echo "Using ${remote} as remote driver for rclone!"
sleep 2
echo

# Check if first sync and run accordingly
source ${path_src}/runFirstSync.sh

# If remote and source were already synced, run update sync
source ${path_src}/runUpdateSync.sh
