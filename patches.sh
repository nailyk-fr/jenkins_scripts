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
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/msm8974-common 913
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/msm8974-common 914
echo -e ${RED}"klsjdfhksdhf"${NC}
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_msm8974-common+branch:android-8.0"  -g https://review.choose-a.name -P device/sony/msm8974-common

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_shinano-common+branch:android-8.0"  -g https://review.choose-a.name -P device/sony/shinano-common --exclude "1017"
$MYFOLDER/repopick.py -g https://review.choose-a.name -P device/sony/shinano-common 1017


cd ~/device/sony/leo
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_leo+branch:android-8.0"  -g https://review.choose-a.name -P device/sony/leo

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
#git fetch lineage cm-14.1
git checkout choose/android-8.0
#git merge lineage/cm-14.1 --no-edit
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_sony_msm8974+branch:android-8.0"  -g https://review.choose-a.name -P kernel/sony/msm8974

cd ~/kernel/ti/omap4
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_ti_omap4+branch:android-8.0"  -g https://gerrit.omnirom.org -P kernel/samsung/tuna

cd ~/device/sony/sepolicy
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch choose android-8.0
git checkout choose/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_sepolicy+branch:android-8.0"  -g https://review.choose-a.name -P device/sony/sepolicy

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_samsung_maguro+branch:android-8.0"  -g https://gerrit.omnirom.org -P device/samsung/maguro

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-8.0
git checkout omnirom/android-8.0
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_samsung_tuna+branch:android-8.0"  -g https://gerrit.omnirom.org -P device/samsung/tuna

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
sed -i 's,HOMEMADE,nailyk,g' config/version.mk
sed -i 's,HOMEMADE,nailyk,g' config/common.mk


echo -e ${GREEN}"-----Patching done --------------"${NC}
