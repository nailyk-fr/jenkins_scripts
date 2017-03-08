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

cd ~/device/qcom/sepolicy
echo "-----Patching $PWD"
patch -p1 < ${MYFOLDER}/patches/fc18176.diff

cd ~/system/sepolicy
echo "-----Patching $PWD"
patch -p1 < ${MYFOLDER}/patches/07adb0c.diff

cd ~/

