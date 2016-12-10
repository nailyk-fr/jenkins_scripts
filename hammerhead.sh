#!/bin/bash

BUILD_VER=""

echo "---------home set to: $HOME"

cd ~/
source ./build/envsetup.sh
export LANG=C
unset _JAVA_OPTIONS
export BUILD_NUMBER=$(date --utc +%Y.%m.%d.%H.%M.%S)
export DISPLAY_BUILD_NUMBER=true

lunch aosp_hammerhead-userdebug
make bootimage -j4
