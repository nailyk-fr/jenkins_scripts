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
repopick -t oreolo-caf # sepolicy rework
repopick 26476 # mkshrc colors
repopick 26426 # nuplayer: Avoid crash when codec fails to load
repopick 26916 # upstream> usb and power hidl 1.1 
repopick 27296 # guard qcom/dataservice makefile
repopick 27269 # Tether HAL

cd ~/frameworks/av
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.0
cd ~/
repopick 26425 # fmwk/av: cameraservice: Resolve message vs start/stop preview races
repopick 25864 # fmwk/av: Don't pass NULL args on setCallbacks call 

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_packages_apps_OpenDelta refs/changes/20/26520/1 && git cherry-pick FETCH_HEAD
git fetch ssh://${PICKOFFICIAL}@gerrit.omnirom.org:29418/android_packages_apps_OpenDelta refs/changes/21/26521/1 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/packages/apps/Dialer
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_packages_apps_Dialer refs/changes/80/27080/2 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/hardware/qcom/power
echo -e ${YELLOW}"-----Patching $PWD"${NC}
# qcom/power D2TW
git reset --hard
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/

cd ~/hardware/qcom/power
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
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
echo -e ${RED}"full pick"${NC}
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/msm8974-common --exclude="27118,27119"
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/sony/msm8974-common 27037 27038 27039 27040 27041 27042 27043 27044 27046 27047 27048 27045

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.0)"  -g https://gerrit.omnirom.org -P device/sony/shinano-common
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/sony/shinano-common 27036

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
git fetch nailyk android-8.0
git checkout nailyk/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:omni_vendor_sony+branch:android-8.0)"  -g https://gerrit.nailyk.fr -P vendor/sony
$MYFOLDER/repopick.py -g https://gerrit.nailyk.fr -P vendor/sony 1079 1080

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
