#!/bin/bash

set -u

# User params
USER_PARAMS=$@

# Internal params
LOG_CMD="tail -f brokerd.log arbiterd.log  brokerd.log  pollerd.log  reactionnerd.log  receiverd.log  schedulerd.log"
RUN_CMD="service shinken restart"
CHANGE_PDW_CMD="cd /var/log/shinken/"
PWD_CMD="pwd"

#######################################
# Echo/log function
# Arguments:
#   String: value to log
#######################################
log() {
  if [[ "$@" ]]; then echo "[`date +'%Y-%m-%d %T'`] $@";
  else echo; fi
}

# Launch
$RUN_CMD
$CHANGE_PDW_CMD
$PWD_CMD
$LOG_CMD
log $LOG_CMD

# Exit immidiately in case of any errors or when we have interactive terminal
if [[ $? != 0 ]] || test -t 0; then exit $?; fi
log