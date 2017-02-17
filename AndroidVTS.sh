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

cd ~/packages/apps/AndroidVTS/
git reset --hard
git clean -fxd :/
git checkout "github/master"
cp ~/scripts/patches/AndroidVTS.mk ~/packages/apps/AndroidVTS/Android.mk

echo "--------AndroidVTS patched"

export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"


cd ~/
lunch aosp_hammerhead-userdebug
make AndroidVTS

cp ~/out/target/product/hammerhead/system/app/AndroidVTS/AndroidVTS.apk /var/jenkins_home/workspace/releases/AndroidVTS/AndroidVTS_$(date +%Y-%m-%d.%H:%M:%S)_signed.apk
