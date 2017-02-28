#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true

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
patch -p1 < ~/scripts/patches/fc18176.diff

cd ~/system/sepolicy
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
patch -p1 < ~/scripts/patches/07adb0c.diff

cd ~/
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

./prebuilts/sdk/tools/jack-admin kill-server

echo "--------jack args $ANDROID_JACK_VM_ARGS"
echo "-----Trigger build from $PWD"
source ./build/envsetup.sh
breakfast z3
make bacon -j6

#kill jack when done to prevent error on other builds
./prebuilts/sdk/tools/jack-admin kill-server
