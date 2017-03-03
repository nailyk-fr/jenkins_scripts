#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD

git config --global user.email jenkins@nailyk.fr
git config --global user.name nailyk-fr         
echo "---------home set to: $HOME"

cd ~/vendor/cm
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/hardware/ti/omap4
echo "-----Patching $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/12/163412/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/13/163413/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/14/163414/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/15/163415/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/16/163416/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/17/163417/1 && git cherry-pick FETCH_HEAD
git fetch https://review.lineageos.org/LineageOS/android_hardware_ti_omap4 refs/changes/20/163420/1 && git cherry-pick FETCH_HEAD


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
