#!/bin/bash

BUILD_VER="nougat-mr0.5-release"

echo "---------home set to: $HOME"

cd ~/
source ./build/envsetup.sh
export LANG=C
unset _JAVA_OPTIONS
export BUILD_NUMBER=$(date --utc +%Y.%m.%d.%H.%M.%S)
export DISPLAY_BUILD_NUMBER=true

cd ~/system/sepolicy
git reset --hard
git clean -fxd :/
git checkout "github/${BUILD_VER}"
patch -p1 < ~/device/lge/hammerhead/patches/system_sepolicy.patch

cd ~/
lunch aosp_hammerhead-userdebug
make bootimage -j4
