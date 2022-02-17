#!/bin/bash

# Check if this is the first sync. If so, no deletions!
if
  [[ $(rclone lsf ${remote}/${name_remote_dir} | egrep '^.sync.check$' | wc -l) == 1 ]] && \
  [[ $(rclone lsf ${path_local_dir} | egrep '^.sync.check$' | wc -l) == 1 ]]
then
  break
elif
  [[ $(rclone lsf ${remote}/${name_remote_dir} | egrep '^.sync.check$' | wc -l) == 1 ]] && \
  [[ $(rclone lsf ${path_local_dir} | egrep '^.sync.check$' | wc -l) == 0 ]]
then
  echo "It seems like this is the first time you sync these folders. For this reason"
  sleep 1
  echo "I'll proceed by just copying the content from remote to local."
  sleep 2
  echo "Please, notice that the target local folder alredy has the following content:"
  sleep 1
  rclone lsf ${path_local_dir}
  echo
  sleep 1
  echo "If duplicates, they will be updated on local. Otherwise, they won't be deleted!"
  [[ $session_interactive == 1 ]] && askProceed
  sleep 2
  echo
  echo "Starting first sync from remote to local!"
  sleep 2
  echo
  rclone copy ${remote}/${name_remote_dir}/ ${path_local_dir} --update --create-empty-src-dirs
  echo
  echo "Done! Ending the script..."
  sleep 2
  exit 0
elif
  [[ $(rclone lsf ${remote}/${name_remote_dir} | egrep '^.sync.check$' | wc -l) == 0 ]] && \
  [[ $(rclone lsf ${path_local_dir} | egrep '^.sync.check$' | wc -l) == 1 ]]
then
  echo "It seems like this is the first time you sync these folders. For this reason"
  sleep 1
  echo "I'll proceed by just copying the content from local to remote."
  sleep 2
  echo "Please, notice that the target remote folder alredy has the following content:"
  sleep 1
  rclone lsf ${remote}/${name_remote_dir}
  echo
  sleep 1
  echo "If duplicates, they will be updated on remote. Otherwise, they won't be deleted!"
  [[ $session_interactive == 1 ]] && askProceed
  sleep 2
  echo
  echo "Starting first sync from local to remote!"
  sleep 2
  echo
  rclone copy ${path_local_dir} ${remote}/${name_remote_dir}/ --update --create-empty-src-dirs
  echo
  echo "Done! Ending the script..."
  sleep 2
  exit 0
else
  echo "It seems like this is the first time you sync these folders."
  sleep 1
  doAlert
  echo "Im order to inform which directory will be the source, create an empty"
  echo "named .sync.check inside the source directory (local or remote)."
  sleep 4
  exit 0
fi
