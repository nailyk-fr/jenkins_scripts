#!/bin/bash

echo "---------home set to: $HOME"

cd ~/vendor/cm
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
git fetch https://review.cyanogenmod.org/CyanogenMod/android_vendor_cm refs/changes/49/175749/5 && git cherry-pick FETCH_HEAD
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/hardware/qcom/display
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
patch -p1 < ~/scripts/patches/e452aa1.diff
patch -p1 < ~/scripts/patches/0962f79.diff

cd ~/hardware/qcom/audio/default
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
patch -p1 < ~/scripts/patches/b4d36dc.diff

cd ~/packages/apps/FMRadio
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
git fetch https://review.cyanogenmod.org/CyanogenMod/android_packages_apps_FMRadio refs/changes/23/176123/1 && git cherry-pick FETCH_HEAD

cd ~/
source ./build/envsetup.sh
breakfast leo
make bacon -j4

