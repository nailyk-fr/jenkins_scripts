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

cd ~/bootable/recovery
echo "-----Patching $PWD"
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/96/22096/3 && git cherry-pick FETCH_HEAD
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/69/22369/1 && git cherry-pick FETCH_HEAD

cd ~/

source ./build/envsetup.sh
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 13
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 14
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 15
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 23

repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 18
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 19
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 20
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 21
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 22
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 28

repopick -g https://gerrit.nailyk.fr -P device/sony/z3 17
repopick -g https://gerrit.nailyk.fr -P device/sony/z3 26
repopick -g https://gerrit.nailyk.fr -P device/sony/z3c 16
repopick -g https://gerrit.nailyk.fr -P device/sony/z3c 27

