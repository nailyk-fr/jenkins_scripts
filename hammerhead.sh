#!/bin/bash

BUILD_VER="nougat-mr1.1-release"
export USER=jenkins
export GRADLE_USER_HOME=$HOME
echo "---------home set to: $HOME"

export ANDROID_HOME=/var/jenkins_home/SDK
/var/jenkins_home/SDK/tools/bin/sdkmanager --update
echo "---------end of sdk update $ANDROID_HOME"

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

echo "--------sepolicyes patched"

cd ~/packages/apps/F-Droid
git reset --hard
git clean -fxd :/
git checkout "github/${BUILD_VER}"
patch -p1 < ~/scripts/patches/fdroid.diff

echo "--------F-droid patched"

cd ~/kernel/lge/hammerhead
git reset --hard
git clean -fxd :/
git checkout "github/cm-14.1"
patch -p1 < ~/device/lge/hammerhead/patches/kernel.diff


echo "--------kernel patched"


export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

./prebuilts/sdk/tools/jack-admin kill-server
./prebuilts/sdk/tools/jack-admin start-server

echo "--------jack restarted with $ANDROID_JACK_VM_ARGS"


cd ~/
lunch aosp_hammerhead-userdebug
make target-files-package -j4
#make bootimage -j4

./prebuilts/sdk/tools/jack-admin kill-server