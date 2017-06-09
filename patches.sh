#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

git config --global user.email "jenkins@nailyk.fr"
git config --global user.name "nailyk-fr"

echo "---------home set to: $HOME"

cd ~/vendor/cm
echo "-----Patching $PWD"
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/

source ./build/envsetup.sh

cd ~/bootable/recovery
echo "-----Patching $PWD"
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/35/23635/1 && git cherry-pick FETCH_HEAD
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/96/22096/9 && git cherry-pick FETCH_HEAD

echo "-----Patching device/sony/msm8974-common"
cd ~/device/sony/msm8974-common
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_device_sony_msm8974-common"  -g https://gerrit.nailyk.fr -P device/sony/msm8974-common --exclude "244"

echo "-----Patching device/sony/shinano-common"
cd ~/device/sony/shinano-common
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_device_sony_shinano-common"  -g https://gerrit.nailyk.fr -P device/sony/shinano-common --exclude "249,248,247,246,196,165,316,270"
# Need to be pick manually, always merge conflicts
#repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 196

echo "-----Patching device/sony/z3"
cd ~/device/sony/z3
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+project:android_device_sony_z3"  -g https://gerrit.nailyk.fr -P device/sony/z3

echo "-----Patching device/sony/z3c"
cd ~/device/sony/z3c
git fetch github cm-14.1
git fetch github cm-14.1_twrp
git checkout github/cm-14.1_twrp
git merge --no-commit github/cm-14.1
git commit --message="Merge cm-14.1" --allow-empty
cd ~/
repopick -Q "status:open+project:android_device_sony_z3c"  -g https://gerrit.nailyk.fr -P device/sony/z3c --exclude "252,80"

echo "-----Patching kernel/sony/msm8974"
cd ~/kernel/sony/msm8974
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_kernel_sony_msm8974"  -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 --exclude "240,241"

# Pending nfc patch
repopick 161917


echo "-----Patching vendor"
cd ~/vendor/sony
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
 repopick -Q "status:open+project:proprietary_vendor_sony" -g https://gerrit.nailyk.fr -P vendor/sony

echo "-----Patching done --------------"
