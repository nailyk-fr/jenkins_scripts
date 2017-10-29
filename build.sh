#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

source $MYFOLDER/colors.sh

cd ~/
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"
export ROM_KEYS_PATH=.android-certs/

./prebuilts/sdk/tools/jack-admin kill-server || true

echo -e ${GREEN}"--------jack args $ANDROID_JACK_VM_ARGS"${NC}
source ./build/envsetup.sh
breakfast $CODENAME
echo -e ${BLUE}"Gonna build $TARGET for $CODENAME"${NC}
mka $TARGET
RET="$?"

#kill jack when done to prevent error on other builds
./prebuilts/sdk/tools/jack-admin kill-server || true

exit $RET

