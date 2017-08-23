#!/bin/bash

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}
echo -e ${GREEN}"Lets merge LineageOS"${NC}

# space separated list of device paths
DEVPATHS="~/device/sony/z3dual ~/device/sony/z3 ~/device/sony/z3c ~/device/sony/shinano-common ~/device/sony/msm8974-common"

# merge
F_MERGE(){
  cd $1
  echo -e ${YELLOW}"-----Merging $PWD"${NC}
  git fetch gerrit cm-14.1_twrp
  git fetch lineage cm-14.1
  git checkout gerrit/cm-14.1_twrp
  git merge lineage/cm-14.1 --no-edit
  git push gerrit HEAD:cm-14.1_twrp  
}

# do a merge for any defined path
for merge in $DEVPATHS;do
  F_MERGE "$merge"
done
