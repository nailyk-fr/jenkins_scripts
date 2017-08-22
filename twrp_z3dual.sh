#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

echo "---------patching"


cd ~/
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx8g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"

./prebuilts/sdk/tools/jack-admin kill-server || true

echo "--------jack args $ANDROID_JACK_VM_ARGS"
echo "-----Trigger build from $PWD"
source ./build/envsetup.sh
breakfast z3dual
make recovery-zip -j6

#kill jack when done to prevent error on other builds
./prebuilts/sdk/tools/jack-admin kill-server || true
