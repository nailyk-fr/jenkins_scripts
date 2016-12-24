#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false

echo "---------home set to: $HOME"

cd ~/vendor/cm
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
git fetch https://review.cyanogenmod.org/CyanogenMod/android_vendor_cm refs/changes/49/175749/5 && git cherry-pick FETCH_HEAD
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/kernel/sony/msm8974
git reset --hard
git clean -fxd :/
git checkout github/aosp/LA.BR.1.3.3_rb2.14
patch -p1 < ~/scripts/patches/usb_workaround.patch

cd ~/hardware/qcom/display
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
patch -p1 < ~/scripts/patches/e452aa1.diff
patch -p1 < ~/scripts/patches/0962f79.diff
patch -p1 < ~/scripts/patches/display_server.diff

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
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

./prebuilts/sdk/tools/jack-admin kill-server

echo "--------jack args $ANDROID_JACK_VM_ARGS"

source ./build/envsetup.sh
breakfast leo
make bacon -j6

