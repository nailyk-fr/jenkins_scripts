#!/bin/bash

BUILD_VER="cm-12.1"

echo "---------home set to: $HOME"

cd ~/vendor/cm
git checkout "github/${BUILD_VER}"
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk
echo "---------vendor cm patched"

cd ~/packages/apps/Browser
git checkout "github/${BUILD_VER}"
git fetch https://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Browser refs/changes/54/163254/1 && git cherry-pick FETCH_HEAD
echo "---------package apps Browser patched"

cd ~/frameworks/base
git checkout "github/${BUILD_VER}"
git fetch https://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/13/157413/2 && git cherry-pick FETCH_HEAD
echo "---------frameworks base patched"

cd ~/device/sony/z3
git checkout "github/${BUILD_VER}"
git fetch https://review.cyanogenmod.org/CyanogenMod/android_device_sony_z3 refs/changes/41/159441/1 && git cherry-pick FETCH_HEAD
echo "---------device sony z3 patched"


cd ~/
source ./build/envsetup.sh
breakfast z3
make toto -j4

