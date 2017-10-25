#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/
source ./build/envsetup.sh
echo -e ${YELLOW}"-----Picking system wide commits"${NC}
repopick 25843 # don't bootloader-reboot on panic
repopick 25847 # adb legacy
repopick 25848 # adb sepolicy
repopick -t oreolo-caf # sepolicy rework
repopick 26073 # warning instead of error on CLANG disabled
repopick 26076 # force grep filename hide on sepolicy commands

cd ~/frameworks/av
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_frameworks_av refs/changes/15/26415/1 && git cherry-pick FETCH_HEAD
#git fetch https://gerrit.omnirom.org/android_frameworks_av refs/changes/61/25861/1 && git cherry-pick FETCH_HEAD
#git fetch https://gerrit.omnirom.org/android_frameworks_av refs/changes/62/25862/1 && git cherry-pick FETCH_HEAD
#git fetch https://gerrit.omnirom.org/android_frameworks_av refs/changes/63/25863/1 && git cherry-pick FETCH_HEAD
#git fetch https://gerrit.omnirom.org/android_frameworks_av refs/changes/64/25864/1 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_frameworks_av refs/changes/26/26426/1 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_frameworks_av refs/changes/25/26425/1 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/hardware/qcom/power
echo -e ${YELLOW}"-----Patching $PWD"${NC}
# qcom/power D2TW
git reset --hard
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
echo -e ${RED}"full pick"${NC}
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/msm8974-common --exclude "1049,1224,1125"
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/msm8974-common 1125

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/shinano-common --exclude="994,995"
cd ~/device/sony/shinano-common

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_leo+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/z3

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_aries+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/z3c

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
#git fetch lineage cm-14.1
git checkout choose/android-8.0
#git merge lineage/cm-14.1 --no-edit
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm8974+branch:android-8.0)"  -g https://review.choose-a.name -P kernel/sony/msm8974

cd ~/kernel/ti/omap4
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_ti_omap4+branch:android-8.0)"  -g https://gerrit.omnirom.org -P kernel/samsung/tuna

cd ~/device/sony/sepolicy
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_sepolicy+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/sepolicy

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_maguro+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/samsung/maguro

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_tuna+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/samsung/tuna

echo -e ${YELLOW}"-----Patching vendor"${NC}
cd ~/vendor/sony
git fetch github android-8.0
git fetch github android-7.1
git checkout github/android-8.0
cd ~/

cd ~/hardware/sony/timekeep
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/


cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/version.mk
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}
