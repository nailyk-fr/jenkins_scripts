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
git checkout github/cm-13.0
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/vendor/samsung
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0
cp ${MYFOLDER}/patches/vendor_omap4-common.mk omap4-common/Android.mk

cd ~/
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

./prebuilts/sdk/tools/jack-admin kill-server

echo "--------jack args $ANDROID_JACK_VM_ARGS"
echo "-----Trigger build from $PWD"
source ./build/envsetup.sh
breakfast maguro
make bacon -j6

#kill jack when done to prevent error on other builds
./prebuilts/sdk/tools/jack-admin kill-server
