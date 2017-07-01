#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

git config --global user.email "jenkins@nailyk.fr"
git config --global user.name "nailyk-fr"

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/vendor/cm
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/

source ./build/envsetup.sh

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/96/22096/9 && git cherry-pick FETCH_HEAD
cd ~/

echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/device/sony/msm8974-common
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_msm8974-common" -P device/sony/msm8974-common

echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/device/sony/shinano-common
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_shinano-common" -P device/sony/shinano-common --exclude "179443,179440"
# Need to be pick manually, always merge conflicts
#repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 196

echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/device/sony/z3
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+project:android_device_sony_z3"  -g https://gerrit.nailyk.fr -P device/sony/z3 --exclude "565"

echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/device/sony/z3c
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+branch:cm-14.1+project:LineageOS/android_device_sony_z3c"  -P device/sony/z3c

echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/kernel/sony/msm8974
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_kernel_sony_msm8974"  -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 --exclude "558"

echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/device/sony/z3dual
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+project:android_device_sony_z3dual"  -g https://gerrit.nailyk.fr -P device/sony/z3dual --exclude "582"


# Pending nfc patch
repopick 161917


echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/vendor/sony
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
 repopick -Q "status:open+project:proprietary_vendor_sony" -g https://gerrit.nailyk.fr -P vendor/sony

echo -e ${GREEN}"-----Patching done --------------"${NC}
