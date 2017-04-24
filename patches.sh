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
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/96/22096/3 && git cherry-pick FETCH_HEAD
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/69/22369/1 && git cherry-pick FETCH_HEAD
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/09/22509/1 && git cherry-pick FETCH_HEAD
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/68/22368/1 && git cherry-pick FETCH_HEAD
cd ~/
repopick -g https://gerrit.omnirom.org -t mr2-custom-fonts -P bootable/recovery

echo "-----Patching device/sony/msm8974-common"
cd ~/device/sony/msm8974-common
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_device_sony_msm8974-common"  -g https://gerrit.nailyk.fr -P device/sony/msm8974-common

echo "-----Patching device/sony/shinano-common"
cd ~/device/sony/shinano-common
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_device_sony_shinano-common"  -g https://gerrit.nailyk.fr -P device/sony/shinano-common --exclude "170,196,199"

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
repopick -Q "status:open+project:android_device_sony_z3c"  -g https://gerrit.nailyk.fr -P device/sony/z3c --exclude "80,148"

echo "-----Patching kernel/sony/msm8974"
cd ~/kernel/sony/msm8974
git fetch github cm-14.1
git checkout github/cm-14.1
cd ~/
repopick -Q "status:open+project:android_kernel_sony_msm8974"  -g https://gerrit.nailyk.fr -P kernel/sony/msm8974

# Pending nfc patch
repopick 161917

echo "-----Patching done --------------"
