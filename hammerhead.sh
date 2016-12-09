#!/bin/bash

BUILD_VER=""

echo "---------home set to: $HOME"

cd ~/
source ./build/envsetup.sh
lunch aosp_hammerhead-userdebug
make bootimage -j4
