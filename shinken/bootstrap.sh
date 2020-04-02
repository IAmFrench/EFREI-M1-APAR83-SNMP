#!/bin/sh

set -u

# User params
USER_PARAMS=$@

# Internal params
LOG_CMD="tail -f /var/log/shinken/brokerd.log"
RUN_CMD="service shinken restart"

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
$LOG_CMD
log $LOG_CMD

# Exit immidiately in case of any errors or when we have interactive terminal
if [[ $? != 0 ]] || test -t 0; then exit $?; fi
log