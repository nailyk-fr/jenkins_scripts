#!/bin/bash

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}
echo -e ${GREEN}"Lets merge LineageOS"${NC}

# list of device paths + branch to fetch/checkout
# the order specified here is the order being processed
# format: FULLPATH:BRANCH (e.g.: /home/foo/bar:master)
DEVPATHS="~/device/sony/z3dual:cm-14.1_twrp \
          ~/device/sony/z3:cm-14.1_twrp \
          ~/device/sony/z3c:cm-14.1_twrp \
          ~/device/sony/shinano-common:cm-14.1 \
          ~/device/sony/msm8974-common:cm-14.1 \
          "

# merge
F_MERGE(){
  MERGPATH=$1
  [ ! -d "$MERGPATH" ] && echo "ERROR: cannot cd into path specified ($MERGPATH)" && exit 3
  cd $MERGPATH
  BRANCH="$2"
  echo -e ${YELLOW}"-----Merging $PWD"${NC}
  git fetch gerrit $BRANCH
  git fetch lineage cm-14.1
  git checkout gerrit/${BRANCH}
  git merge lineage/cm-14.1 --no-edit
  git push gerrit HEAD:${BRANCH}
}

# do a merge for any defined path
for merge in $DEVPATHS;do
  F_MERGE "${merge/:*/}" "${merge/*:/}"
done
