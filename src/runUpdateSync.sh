#!/bin/bash

# Sync starting with the most recently modified
last_mod_local=$(rclone lsf --format "t" -R ${path_local_dir} | sort -r | head -n 1)
last_mod_remote=$(rclone lsf --format "t" -R ${remote}/${name_remote_dir} | sort -r | head -n 1)

echo
echo
[[ $last_mod_remote > $last_mod_local ]] && echo "Remote directory was most recently modified!"
[[ $last_mod_remote < $last_mod_local ]] && echo "Local directory was most recently modified!"
sleep 2
echo

[[ $session_interactive == 1 ]] && askProceed

if [[ $last_mod_remote > $last_mod_local ]]; then
  echo
  echo "Syncing from remote ${remote}/${name_remote_dir} to local ${path_local_dir}!"
  echo
  sleep 4
  rclone sync ${remote}/${name_remote_dir} ${path_local_dir} --update --create-empty-src-dirs
  echo "Done!"
  sleep 2
  echo
  echo
  echo "Syncing from local ${path_local_dir} to remote ${remote}/${name_remote_dir}!"
  echo
  sleep 4
  rclone sync ${path_local_dir} ${remote}/${name_remote_dir} --update --create-empty-src-dirs
  echo "Done!"
  sleep 2
  echo
else
  echo
  echo "Syncing from local ${path_local_dir} to remote ${remote}/${name_remote_dir}!"
  echo
  sleep 4
  rclone sync ${path_local_dir} ${remote}/${name_remote_dir} --update --create-empty-src-dirs
  echo "Done!"
  sleep 2
  echo
  echo
  echo "Syncing from remote ${remote}/${name_remote_dir} to local ${path_local_dir}!"
  echo
  sleep 4
  rclone sync ${remote}/${name_remote_dir} ${path_local_dir} --update --create-empty-src-dirs
  echo "Done!"
  sleep 2
  echo
fi
