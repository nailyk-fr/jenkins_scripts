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
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 18
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 19
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 20
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 21
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 22
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 28
repopick -g https://gerrit.nailyk.fr -P device/sony/shinano-common 69

echo "-----Patching device/sony/z3"
repopick -g https://gerrit.nailyk.fr -P device/sony/z3 17
repopick -g https://gerrit.nailyk.fr -P device/sony/z3 26
echo "-----Patching device/sony/z3c"
repopick -g https://gerrit.nailyk.fr -P device/sony/z3c 16
repopick -g https://gerrit.nailyk.fr -P device/sony/z3c 27

echo "-----Patching kernel/sony/msm8974"
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 13
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 14
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 15
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 23
repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 29
for i in {47..68}
do
  repopick -g https://gerrit.nailyk.fr -P kernel/sony/msm8974 $i
done

echo "-----Patching done --------------"
