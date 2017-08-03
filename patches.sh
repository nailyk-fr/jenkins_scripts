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

cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,nailyk,g' config/version.mk
sed -i 's,HOMEMADE,nailyk,g' config/common.mk

cd ~/

source ./build/envsetup.sh

echo -e ${YELLOW}"-----Patching device/sony/common"${NC}
cd ~/device/sony/common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_common"  -g https://review.choose-a.name -P device/sony/common --exclude "525,532,533,534,535,536,537,538,539,540,541,542,543,544"

echo -e ${YELLOW}"-----Patching device/sony/msm8974-common"${NC}
cd ~/device/sony/msm8974-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_msm8974-common"  -g https://review.choose-a.name -P device/sony/msm8974-common
cd ~/device/sony/msm8974-common && rm boot/custombootimg.mk

echo -e ${YELLOW}"-----Patching device/sony/shinano-common"${NC}
cd ~/device/sony/shinano-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_shinano-common"  -g https://review.choose-a.name -P device/sony/shinano-common --exclude "599"

echo -e ${YELLOW}"-----Patching device/sony/leo"${NC}
cd ~/device/sony/leo
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_device_sony_leo"  -g https://review.choose-a.name -P device/sony/leo
cd ~/device/sony/leo
git cherry-pick 424b142
git cherry-pick b5aae33

echo -e ${YELLOW}"-----Patching kernel/sony/msm8974"${NC}
cd ~/kernel/sony/msm8974
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:android_kernel_sony_msm8974"  -g https://review.choose-a.name -P kernel/sony/msm8974 --exclude "670"

echo -e ${YELLOW}"-----Patching vendor"${NC}
cd ~/vendor/sony
git fetch choosea android-7.1
git checkout choosea/android-7.1
cd ~/
$MYFOLDER/repopick.py -Q "status:open+project:DonkeyCoyote/proprietary_vendor_sony" -g https://review.choose-a.name -P vendor/sony
$MYFOLDER/repopick.py -g https://review.choose-a.name -P vendor/sony 200 -f

cd ~/hardware/sony/timekeep
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch omnirom android-7.1
git checkout omnirom/android-7.1
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P hardware/sony/timekeep 24380

echo -e ${GREEN}"-----Patching done --------------"${NC}
