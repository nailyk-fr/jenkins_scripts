#!/bin/bash

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}
echo -e ${GREEN}"Lets merge LineageOS"${NC}

cd ~/device/sony/z3dual
echo -e ${YELLOW}"-----Merging $PWD"${NC}
git fetch gerrit cm-14.1_twrp
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1_twrp
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1_twrp

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Merging $PWD"${NC}
git fetch gerrit cm-14.1_twrp
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1_twrp
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1_twrp

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Merging $PWD"${NC}
git fetch gerrit cm-14.1_twrp
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1_twrp
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1_twrp

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Merging $PWD"${NC}
git fetch gerrit cm-14.1
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Merging $PWD"${NC}
git fetch gerrit cm-14.1
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1
