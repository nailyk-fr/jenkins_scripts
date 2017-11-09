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
repopick 26452 # fmwk/base QCOM_BSP
repopick 26476 # mkshrc colors
repopick 26426 # nuplayer: Avoid crash when codec fails to load
repopick 24669 # twrp: disable app
repopick 26651 # Omniclock: add fallback

cd ~/frameworks/av
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.0
cd ~/
repopick 26425 # fmwk/av: cameraservice: Resolve message vs start/stop preview races
repopick 26415 # fmwk/av: Revert "Camera: Cleanup 'CameraModule' dependend code"
repopick 26474 # fmwk/av: Support for legacy camera HALv1 
repopick 25863 # fmwk/av: Fix legacy HAL1 after merge of android-7.1.0_r7 
repopick 25864 # fmwk/av: Don't pass NULL args on setCallbacks call 

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_packages_apps_OpenDelta refs/changes/20/26520/1 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_packages_apps_OpenDelta refs/changes/21/26521/1 && git cherry-pick FETCH_HEAD
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
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
echo -e ${RED}"full pick"${NC}
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/msm8974-common --exclude="26557"

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/shinano-common
cd ~/device/sony/shinano-common

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/z3

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3c+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/z3c

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z2+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/z2

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm8974+branch:android-8.0)"  -g https://gerrit.omnirom.org -P kernel/sony/msm8974 --exclude "26500"

cd ~/kernel/ti/omap4
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_ti_omap4+branch:android-8.0)"  -g https://gerrit.omnirom.org -P kernel/samsung/tuna

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
