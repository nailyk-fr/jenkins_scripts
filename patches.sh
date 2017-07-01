#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

#https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux#5947802
RED='\e[0;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
YELLOW='\e[1;33m'
NC='\e[0m' # No Color

git config --global user.email "jenkins@nailyk.fr"
git config --global user.name "nailyk-fr"

echo -e ${GREEN}"---------home set to: $HOME"{NC}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,nailyk,g' config/version.mk
sed -i 's,HOMEMADE,nailyk,g' config/common.mk

cd ~/

source ./build/envsetup.sh

echo -e ${YELLOW}"-----Patching device/sony/msm8974-common"${NC}
cd ~/device/sony/msm8974-common
git fetch choose android-7.1
git checkout choose/android-7.1
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
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_sony_msm8974"  -g https://review.choose-a.name -P kernel/sony/msm8974

echo -e ${YELLOW}"-----Patching vendor"${NC}
cd ~/vendor/sony
git fetch choosea android-7.1
git checkout choosea/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:DonkeyCoyote/proprietary_vendor_sony" -g https://review.choose-a.name -P vendor/sony

echo -e ${GREEN}"-----Patching done --------------"${NC}
