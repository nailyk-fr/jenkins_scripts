#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

git config --global user.email "jenkins@nailyk.fr"
git config --global user.name "nailyk-fr"

echo -e ${GREEN}"---------home set to: $HOME"{NC}

cd ~/
source ./build/envsetup.sh
echo -e ${YELLOW}"-----Picking system wide commits"${NC}
repopick -t theme_me_up_scotty
repopick 24611
repopick 22096
repopick 22565


echo -e ${YELLOW}"-----Patching device/sony/common"${NC}
cd ~/device/sony/common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_common"  -g https://review.choose-a.name -P device/sony/common --exclude "525"

echo -e ${YELLOW}"-----Patching device/sony/msm8974-common"${NC}
cd ~/device/sony/msm8974-common
git fetch choose android-7.1
git checkout choose/android-7.1
git fetch https://review.choose-a.name/android_device_sony_msm8974-common refs/changes/58/258/8 && git cherry-pick FETCH_HEAD
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_msm8974-common"  -g https://review.choose-a.name -P device/sony/msm8974-common

echo -e ${YELLOW}"-----Patching device/sony/shinano-common"${NC}
cd ~/device/sony/shinano-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_shinano-common"  -g https://review.choose-a.name -P device/sony/shinano-common

echo -e ${YELLOW}"-----Patching device/sony/leo"${NC}
cd ~/device/sony/leo
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_leo"  -g https://review.choose-a.name -P device/sony/leo

echo -e ${YELLOW}"-----Patching kernel/sony/msm8974"${NC}
cd ~/kernel/sony/msm8974
git fetch choose android-7.1
#git fetch lineage cm-14.1
git checkout choose/android-7.1
#git merge lineage/cm-14.1 --no-edit
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_sony_msm8974"  -g https://review.choose-a.name -P kernel/sony/msm8974 --exclude "786,787"

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
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_sepolicy"  -g https://review.choose-a.name -P device/sony/sepolicy

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
git fetch choosea android-7.1
git checkout choose/android-7.1
cd ~/
#$MYFOLDER/repopick.py -Q "status:open+project:DonkeyCoyote/proprietary_vendor_sony" -g https://review.choose-a.name -P vendor/sony
$MYFOLDER/repopick.py -g https://review.choose-a.name -P vendor/sony 757

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
