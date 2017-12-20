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
repopick 27635 # mkshrc colors
repopick 27636 # nuplayer: Avoid crash when codec fails to load
repopick 27637 # guard qcom/dataservice makefile
repopick 27638 # qcom/sepolicy sdcard

cd ~/frameworks/av
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.1
cd ~/

cd ~/system/vold
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.1
cd ~/
repopick 27641 # Disable sdcard_posix context force 

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
repopick 27639
repopick 27640

cd ~/packages/apps/Dialer
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/

cd ~/hardware/qcom/power
echo -e ${YELLOW}"-----Patching $PWD"${NC}
# qcom/power D2TW
git reset --hard
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/

cd ~/hardware/qcom/gps
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git clean -fxd :/
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
# allow msm8994 use by msm8974
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_hardware_qcom_gps refs/changes/08/27308/1 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
echo -e ${RED}"full pick"${NC}
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/msm8974-common

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/shinano-common

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/z3

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3c+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/z3c

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z2+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/z2

cd ~/device/oneplus/oneplus5
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/oneplus/oneplus5 -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_oneplus_oneplus5+branch:android-8.1)" --exclude "27415,27416"

cd ~/device/oneplus/oneplus5t
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/oneplus/oneplus5t -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_oneplus_oneplus5t+branch:android-8.1)"

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm8974+branch:android-8.1)"  -g https://gerrit.omnirom.org -P kernel/sony/msm8974 --exclude "26500"

cd ~/kernel/oneplus/msm8998
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P kernel/oneplus/msm8998  -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_oneplus_msm8998+branch:android-8.1)" 

cd ~/kernel/ti/omap4
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_ti_omap4+branch:android-8.1)"  -g https://gerrit.omnirom.org -P kernel/samsung/tuna

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_maguro+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/samsung/maguro

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_tuna+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/samsung/tuna

echo -e ${YELLOW}"-----Patching vendor"${NC}
cd ~/vendor/sony
git fetch github android-8.1
git fetch nailyk android-8.1
git checkout nailyk/android-8.1
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:omni_vendor_sony+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P vendor/sony

cd ~/hardware/sony/timekeep
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.1
git checkout omnirom/android-8.1
cd ~/


cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/version.mk
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}
