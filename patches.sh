#!/bin/bash

V_OLDHOME=$HOME
HOME=$PWD

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"
BRANCH="android-9.0"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh
source $MYFOLDER/functions.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}


cd ~/
source ./build/envsetup.sh
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching toolchain .o0o. .o0o..o0o..o0o."${NC}
echo -e ${YELLOW}"-----Picking system wide commits"${NC}

echo -e ${YELLOW}"-----Patching OpenDelta"${NC}
V_PSET="27639 27640"
pick_custom

# pick twrp fixes
repopick -t omni-fix

# Fix for device/sample/apns.xml
repopick 34004

V_URI=https://gerrit.omnirom.org

V_REPO=android_device_sony_msm8974-common
V_PATH=device/sony/msm8974-common
pick_repo


V_REPO=android_device_sony_shinano-common
V_PATH=device/sony/shinano-common
pick_repo

V_REPO=android_device_sony_z3
V_PATH=device/sony/z3
pick_repo

V_REPO=android_device_sony_z3c
V_PATH=device/sony/z3c
pick_repo

V_REPO=android_device_sony_z2
V_PATH=device/sony/z2
pick_repo

V_REPO=android_kernel_sony_msm8974
V_PATH=kernel/sony/msm8974
pick_repo

########### custom gerrit

V_URI=https://gerrit.nailyk.fr

V_REPO=android_device_sony_yoshino
V_PATH=device/sony/yoshino
pick_repo

V_REPO=android_device_sony_lilac
V_PATH=device/sony/lilac
pick_repo


V_REPO=android_device_sony_common-treble
V_PATH=device/sony/common-treble
pick_repo

V_REPO=android_kernel_sony_msm8998
V_PATH=kernel/sony/msm8998
pick_repo

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching vendors .o0o. .o0o..o0o..o0o."${NC}

V_REPO=omni_vendor_sony
V_PATH=vendor/sony
pick_repo


echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/version.mk
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}


HOME=$V_OLDHOME
