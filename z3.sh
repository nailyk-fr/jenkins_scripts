#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false

echo "---------home set to: $HOME"

cd ~/vendor/cm
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1
git fetch https://review.lineageos.org/LineageOS/android_vendor_cm refs/changes/88/144688/5 && git cherry-pick FETCH_HEAD
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/kernel/sony/msm8974
git reset --hard
git clean -fxd :/
git checkout github/aosp/LA.BR.1.3.3_rb2.14
patch -p1 < ~/scripts/patches/usb_workaround.patch
patch -p1 < ~/scripts/patches/calls_reboot.patch

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
#git fetch https://review.lineageos.org/LineageOS/android_packages_apps_FMRadio refs/changes/16/122216/1 && git cherry-pick FETCH_HEAD


cd ~/
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

./prebuilts/sdk/tools/jack-admin kill-server

echo "--------jack args $ANDROID_JACK_VM_ARGS"

source ./build/envsetup.sh
breakfast z3
make bacon -j6

#kill jack when done to prevent error on other builds
./prebuilts/sdk/tools/jack-admin kill-server
