#!/bin/bash

# Start the AccVimaccRoot
/opt/Accellence/vimacc/bin/AccVimaccRoot&
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start AccVimaccRoot: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
while sleep 60; do
  ps aux |grep AccVimaccRoot |grep -q -v grep
  PROCESS_1_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "AccVimaccRoot has been exited."
    exit 1
  fi
done