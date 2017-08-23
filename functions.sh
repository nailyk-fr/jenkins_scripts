##########################################################################
# global functions
#
# include this with:
# source functions.sh
#
# brought to you by: steadfasterX <steadfastX@boun.cr>
##########################################################################

# echo output and save it in a log as well
F_ECHOLOG(){
  # takes 1 argument
  # 1 => Message to log/echo (can handle \t and \n)
  
  echo -e "$1"
  # TODO: write log..
}

# check errorcode + exit when not errorcode not as expected
F_ERR(){
  # takes 3 arguments
  # mandantory:
  #   1 => the process initiating this function
  #   2 => the errorcode (usually $? in your call)
  # optional:
  #   3 => the expected error code (if missing we expect 0)
  CALLER=$1
  ERRCODE=$2
  EXPECTED=$3
  [ -z "$EXPECTED" ] && EXPECTED=0
  
  if [ -z "$CALLER" ]||[ -z "$ERRCODE" ];then
    F_ECHOLOG "Required argument missing in $FUNCNAME!"
    F_EXIT $FUNCNAME 3
  fi
  if [ "$ERRCODE" != "$EXPECTED" ];then
    echo "ERROR: $ERRCODE occurred in $CALLER (expected $EXPECTED, got $ERRCODE)"
    F_EXIT "${CALLER}->${FUNCNAME}" 4
  else
    echo "OK: $CALLER"
  fi
}

# exit properly
F_EXIT(){
  # takes 2 arguments (mandantory)
  # 1 => the function or reason who calls the exit function
  # 2 => the exitcode to be used
  EREASON=$1
  ECODE=$2
  
  F_ECHOLOG "EXIT: $EREASON with code $ECODE"
  
  # TODO (optional): do any other actions
  exit $ECODE
}
