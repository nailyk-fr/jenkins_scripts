#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/vendor/cm
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,UNOFFICIAL,'${PICKLINEAGE}',g' config/common.mk

cd ~/

source ./build/envsetup.sh

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/96/22096/9 && git cherry-pick FETCH_HEAD
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/69/24669/4 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_msm8974-common" -P device/sony/msm8974-common --exclude "179539,181581,181577,181578"
repopick 181581
repopick 181577
repopick 181578

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_shinano-common" -P device/sony/shinano-common --exclude "181579,181545,181583,181545,181879,181937"
repopick -P device/sony/shinano-common 181579
repopick -P device/sony/shinano-common 181545
cd ~/device/sony/shinano-common

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_z3" -P device/sony/z3

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_z3c"  -P device/sony/z3c --exclude "181664"

cd ~/device/sony/z3dual
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_z3dual" -P device/sony/z3dual

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
#git fetch github cm-14.1_twrp
git checkout github/cm-14.1
#git checkout github/cm-14.1_twrp
cd ~/
repopick -Q "status:open+project:android_device_samsung_tuna+branch:cm-14.1" -g https://gerrit.nailyk.fr -P device/samsung/tuna

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
#git fetch github cm-14.1_twrp
git checkout github/cm-14.1
#git checkout github/cm-14.1_twrp
cd ~/
repopick -Q "status:open+project:android_device_samsung_maguro+branch:cm-14.1" -g https://gerrit.nailyk.fr -P device/samsung/maguro

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_kernel_sony_msm8974" -P kernel/sony/msm8974

cd ~/kernel/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:android_kernel_samsung_tuna+branch:cm-14.1" -g https://gerrit.nailyk.fr -P kernel/samsung/tuna

cd ~/vendor/sony
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github regen_z3dual
git checkout github/regen_z3dual
git fetch http://gerrit.nailyk.fr/proprietary_vendor_sony refs/changes/77/977/1 && git cherry-pick FETCH_HEAD
cd ~/
#repopick -Q "status:open+project:proprietary_vendor_sony" -g https://gerrit.nailyk.fr -P vendor/sony --exclude "888"

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:proprietary_vendor_samsung+branch:cm-14.1" -g https://gerrit.nailyk.fr -P vendor/samsung

cd ~/vendor/ti
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github master
git checkout github/master
cd ~/
repopick -Q "status:open+project:proprietary_vendor_ti+branch:cm-14.1" -g https://gerrit.nailyk.fr -P vendor/ti

echo -e ${GREEN}"-----Grabing global patches"${NC}
repopick 182472

echo -e ${GREEN}"-----Patching done --------------"${NC}


