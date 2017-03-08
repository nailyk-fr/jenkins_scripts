#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD

echo "---------home set to: $HOME"

cd ~/vendor/cm
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/device/qcom/sepolicy
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
patch -p1 < ${MYFOLDER}/patches/fc18176.diff

cd ~/system/sepolicy
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
patch -p1 < ${MYFOLDER}/patches/07adb0c.diff

cd ~/
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

