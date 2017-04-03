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

echo "-----Patching device/sony/shinano-common"
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 69
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 70

echo "-----Patching device/sony/z3c"
repopick -g https://gerrit.nailyk.fr -P device/sony/z3c 80

echo "-----Patching kernel/sony/msm8974"
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 90
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 91

# Pending nfc patch
repopick 161917

echo "-----Patching done --------------"
