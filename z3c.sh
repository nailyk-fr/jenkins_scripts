#!/bin/bash

BUILD_VER="cm-12.1"
export USER=jenkins
export LANG=C
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/"

echo "---------home set to: $HOME"

cd ~/vendor/cm
git reset --hard
git clean -fxd :/
git checkout "github/${BUILD_VER}"
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk
echo "---------vendor cm patched"

cd ~/packages/apps/Browser
git reset --hard
git clean -fxd :/
git checkout "github/${BUILD_VER}"
#git fetch https://review.lineageos.org/LineageOS/android_packages_apps_Browser refs/changes/52/110752/1 && git cherry-pick FETCH_HEAD
echo "---------package apps Browser patched"

cd ~/frameworks/base
git reset --hard
git clean -fxd :/
git checkout "github/${BUILD_VER}"
#git fetch https://review.lineageos.org/LineageOS/android_frameworks_base refs/changes/64/65064/2 && git cherry-pick FETCH_HEAD
echo "---------frameworks base patched"

cd ~/device/sony/z3c
git reset --hard
git clean -fxd :/
git checkout "github/${BUILD_VER}"
#git fetch https://review.lineageos.org/LineageOS/android_device_sony_z3 refs/changes/65/56765/1 && git cherry-pick FETCH_HEAD
patch -p1 < ~/scripts/patches/z3c_defconfig.diff
echo "---------device sony z3c patched"


cd ~/
source ./build/envsetup.sh
breakfast z3c
make bacon -j6

