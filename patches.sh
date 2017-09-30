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
repopick -t oreolo-caf  # sepolicy rework
repopick 26073 # warning instead of error on CLANG disabled

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
echo -e ${RED}"omni.dependencies"${NC}
#omni.dependencies: 
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/msm8974-common 913 914 1039 1040 1041
echo -e ${RED}"power"${NC}
#power: 
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/msm8974-common 922 923 1048 1049 1050
echo -e ${RED}"full pick"${NC}
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/msm8974-common --exclude "913,914,1039,1040,1041,922,923,1048,1049,1050,1013,1071,1072,1095,969,970,967"
#filesystem
echo -e ${RED}"FS users"${NC}
cd ~/device/sony/msm8974-common
git fetch https://review.choose-a.name/android_device_sony_msm8974-common refs/changes/71/1071/4 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.0)"  -g https://review.choose-a.name -P device/sony/shinano-common --exclude "1017,1072,1101,996"
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/shinano-common 1072
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/shinano-common 1101


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
sed -i 's,HOMEMADE,${PICKOFFICIAL},g' config/version.mk
sed -i 's,HOMEMADE,${PICKOFFICIAL},g' config/common.mk

echo -e ${GREEN}"-----Patching done --------------"${NC}
