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

cd ~/
source ./build/envsetup.sh
echo -e ${YELLOW}"-----Picking system wide commits"${NC}
repopick -t theme_me_up_scotty
repopick 24611 # vendor/omni: omni: Tools: Add dtbToolCM
repopick 22096 # twrp Fix for LineageOS build
repopick 22565 # twrp Adopted Storage: Add support for mixed mode sdcards
repopick 24669 # twrp disable twrp app
repopick 25015 # twrp OTA encrypted workaround
repopick 25938 # twrp dont unsecure twrp

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_packages_apps_OpenDelta refs/changes/19/26219/1 && git cherry-pick FETCH_HEAD
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_packages_apps_OpenDelta refs/changes/20/26220/1 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/hardware/qcom/power
# qcom/power D2TW
git reset --hard
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
cd ~/

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_system_sepolicy refs/changes/54/25954/2 && git cherry-pick FETCH_HEAD
cd /~

echo -e ${YELLOW}"-----Patching device/sony/common"${NC}
cd ~/device/sony/common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_common+android-7.1"  -g https://review.choose-a.name -P device/sony/common --exclude "525"

echo -e ${YELLOW}"-----Patching device/sony/msm8974-common"${NC}
cd ~/device/sony/msm8974-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_msm8974-common+android-7.1"  -g https://review.choose-a.name -P device/sony/msm8974-common

echo -e ${YELLOW}"-----Patching device/sony/shinano-common"${NC}
cd ~/device/sony/shinano-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_shinano-common+android-7.1"  -g https://review.choose-a.name -P device/sony/shinano-common

echo -e ${YELLOW}"-----Patching device/sony/z3"${NC}
cd ~/device/sony/z3
git fetch choose android-7.1_z3
git checkout choose/android-7.1_z3
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_z3+android-7.1"  -g https://review.choose-a.name -P device/sony/z3
cd ~/device/sony/z3
git fetch ssh://nailyk-fr@review.choose-a.name:29418/android_device_sony_leo refs/changes/79/1179/2 && git cherry-pick FETCH_HEAD

echo -e ${YELLOW}"-----Patching device/sony/z3c"${NC}
cd ~/device/sony/z3c
git fetch choose android-7.1_z3c
git checkout choose/android-7.1_z3c
cd ~/
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/z3c 1065
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_z3c+android-7.1"  -g https://review.choose-a.name -P device/sony/z3c

echo -e ${YELLOW}"-----Patching kernel/sony/msm8974"${NC}
cd ~/kernel/sony/msm8974
git fetch choose android-7.1
#git fetch lineage cm-14.1
git checkout choose/android-7.1
#git merge lineage/cm-14.1 --no-edit
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_sony_msm8974+android-7.1"  -g https://review.choose-a.name -P kernel/sony/msm8974 --exclude "786,787"

cd ~/kernel/ti/omap4
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_ti_omap4+branch:android-7.1"  -g https://gerrit.omnirom.org -P kernel/samsung/tuna

cd ~/device/sony/sepolicy
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_sepolicy+android-7.1"  -g https://review.choose-a.name -P device/sony/sepolicy

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_samsung_maguro+branch:android-7.1"  -g https://gerrit.omnirom.org -P device/samsung/maguro

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_samsung_tuna+branch:android-7.1"  -g https://gerrit.omnirom.org -P device/samsung/tuna

echo -e ${YELLOW}"-----Patching vendor"${NC}
cd ~/vendor/sony
#git fetch github android-7.1
#git checkout github/android-7.1
git fetch nailyk unified
git checkout nailyk/unified
#cd ~/
#$MYFOLDER/repopick.py -Q "status:open+project:DonkeyCoyote/proprietary_vendor_sony" -g https://review.choose-a.name -P vendor/sony --exclude "398,798,885"

cd ~/hardware/sony/timekeep
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P hardware/sony/timekeep 24380


cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,nailyk,g' config/version.mk
sed -i 's,HOMEMADE,nailyk,g' config/common.mk


echo -e ${GREEN}"-----Patching done --------------"${NC}
