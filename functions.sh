#!/bin/bash

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

cleanup_repo () {

  if [[ ! ${V_REPO:-} ]]
  then
      echo -e "${RED}ERR Cannot cleanup, V_REPO is undefined!${NC}"
      return 4
  fi

  if [[ ! ${V_PATH:-} ]]
  then
      echo -e "${RED}ERR Cannot cleanup ${V_REPO}, V_PATH is undefined!${NC}"
      return 3
  fi
  if [[ ! -d ${V_PATH} ]]
  then
      echo -e "${RED}ERR Cannot cleanup ${V_PATH}, directory does not exist${NC}"
      return 2
  fi

  echo -e "${GREEN}----- Cleaning ${V_PATH} from ${V_REPO}"


  a_oldpath=$PWD
  cd ${V_PATH}
  git reset --hard
  git clean -fxd :/
  git checkout ${V_REPO}
  cd ${a_oldpath}

}

pick_custom () {

  COMMAND=""

  if [[ ${V_QUERY:-} ]]
  then
    COMMAND="${COMMAND} -Q ${V_QUERY}"
  fi

  if [[ ${V_PATH:-} ]]
  then
    COMMAND="${COMMAND} -P ${V_PATH}"
    echo -e "${GREEN}----- Patching ${V_PATH}"
  fi

  if [[ ${V_URI:-} ]]
  then
    COMMAND="${COMMAND} -g ${V_URI}"
  fi

  if [[ ${V_EXCLUDE:-} ]]
  then
    COMMAND="${COMMAND} --exclude ${V_EXCLUDE}"
  fi

  if [[ ! ${COMMAND:-} ]]
  then
    if [[ ${V_PSET:-} ]]
    then
      COMMAND="${COMMAND} ${V_PSET}"
    else
      echo -e "${YELLOW} Nothing to do, skipping${NC}"
      return 1
    fi
  fi

  echo $MYFOLDER/repopick.py ${COMMAND}

  V_QUERY=""
  V_QUERY=""
  V_EXCLUDE=""
  V_PSET=""

  unset V_QUERY
  unset V_PATH
  unset V_EXCLUDE
  unset V_PSET

}

pick_repo () {
	if [[ ! ${V_REPO:-} ]]
	then
		echo -e "${RED}ERR Nothing to do, V_REPO is empty${NC}"
		return 6
	fi

	V_QUERY="\"NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:${V_REPO}+branch:${BRANCH})\""
	pick_custom

    V_REPO=""
    unset V_REPO

}
