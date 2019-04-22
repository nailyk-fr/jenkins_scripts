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
