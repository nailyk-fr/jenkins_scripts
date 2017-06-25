#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

git config --global user.email "jenkins@nailyk.fr"
git config --global user.name "nailyk-fr"

echo "---------home set to: $HOME"

cd ~/vendor/omni
echo "-----Patching $PWD"
sed -i 's,HOMEMADE,nailyk,g' config/version.mk
sed -i 's,HOMEMADE,nailyk,g' config/common.mk

cd ~/

source ./build/envsetup.sh

echo "-----Patching device/sony/msm8974-common"
cd ~/device/sony/msm8974-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick -Q "status:open+project:android_device_sony_msm8974-common"  -g https://review.choose-a.name -P device/sony/msm8974-common

echo "-----Patching device/sony/shinano-common"
cd ~/device/sony/shinano-common
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick -Q "status:open+project:android_device_sony_shinano-common"  -g https://review.choose-a.name -P device/sony/shinano-common

echo "-----Patching device/sony/leo"
cd ~/device/sony/leo
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick -Q "status:open+project:android_device_sony_leo"  -g https://review.choose-a.name -P device/sony/leo

echo "-----Patching kernel/sony/msm8974"
cd ~/kernel/sony/msm8974
git fetch choose android-7.1
git checkout choose/android-7.1
cd ~/
$MYFOLDER/repopick -Q "status:open+project:android_kernel_sony_msm8974"  -g https://review.choose-a.name -P kernel/sony/msm8974

echo "-----Patching vendor"
cd ~/vendor/sony
git fetch choosea android-7.1
git checkout choosea/android-7.1
cd ~/
$MYFOLDER/repopick -Q "status:open+project:DonkeyCoyote/proprietary_vendor_sony" -g https://review.choose-a.name -P vendor/sony

echo "-----Patching done --------------"
