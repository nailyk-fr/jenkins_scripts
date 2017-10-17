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
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/27/927/16 && git cherry-pick FETCH_HEAD
cd ~/
echo -e ${RED}"full pick"${NC}
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/msm8974-common --exclude "1136,1144,1145,1146,1171,1173,927"
cd ~/device/sony/msm8974-common
echo -e ${RED}"keita protect:"${NC}
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/36/1136/7 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/44/1144/5 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/45/1145/5 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/46/1146/5 && git cherry-pick FETCH_HEAD

git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/71/1171/1 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/73/1173/5 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/86/1186/3 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_msm8974-common refs/changes/87/1187/4 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/shinano-common --exclude "1101,977,1165,1154"
cd ~/device/sony/shinano-common
git fetch https://review.choose-a.name/android_device_sony_shinano-common refs/changes/77/977/11 && git cherry-pick FETCH_HEAD
git fetch https://review.choose-a.name/android_device_sony_shinano-common refs/changes/01/1101/16 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_shinano-common refs/changes/54/1154/2 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKCUSTOM}@review.choose-a.name:29418/android_device_sony_shinano-common refs/changes/70/1170/1 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/device/sony/leo
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_leo+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/leo

cd ~/device/sony/aries
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_aries+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/aries

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
git cherry-pick 9f0f05e9ccfd5a126924530ca0466ce157178eae
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

echo -e ${GREEN}"-----Patching done --------------"${NC}
