#!/bin/bash

BUILD_VER=""

echo "---------home set to: $HOME"

cd ~/
source ./build/envsetup.sh
breakfast hammerhead
make toto -j4
