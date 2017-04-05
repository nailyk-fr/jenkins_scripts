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

echo "-----Patching device/sony/msm8974-common"
repopick -g https://gerrit.nailyk.fr -P device/sony/msm8974-common 123

echo "-----Patching device/sony/shinano-common"
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 69
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 70
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 124
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 125
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 126

echo "-----Patching device/sony/z3c"
repopick -g https://gerrit.nailyk.fr -P device/sony/z3c 80

echo "-----Patching kernel/sony/msm8974"
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 90
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 91

# Pending nfc patch
repopick 161917

echo "-----Patching done --------------"
