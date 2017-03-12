#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

echo "---------home set to: $HOME"

cd ~/vendor/cm
echo "-----Patching $PWD"
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/bootable/recovery
echo "-----Patching $PWD"
git fetch https://gerrit.omnirom.org/android_bootable_recovery refs/changes/96/22096/3 && git cherry-pick FETCH_HEAD

cd ~/

