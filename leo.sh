#!/bin/bash

echo "---------home set to: $HOME"

cd ~/vendor/cm
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
git fetch https://review.cyanogenmod.org/CyanogenMod/android_vendor_cm refs/changes/49/175749/5 && git cherry-pick FETCH_HEAD
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/
source ./build/envsetup.sh
breakfast leo
make toto -j4

