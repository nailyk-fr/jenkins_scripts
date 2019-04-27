#!/bin/bash

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
repopick 27693 # twrp: Cleanup flags
repopick 27694 # twrp: Remove APP
repopick 28631 # twrp: scrypt <machine/cpu-features.h>.
repopick 27792 # twrp: ext4: force keymaster v1 (Probably useless as is for FBE)
repopick 32479
repopick 32480 # twrp: fix vndk for arm32
repopick 32481
repopick 32482
repopick 32483
repopick 32636 # twrp: fix dosfstools on arm32
repopick 32647
repopick 32648
repopick 32714

repopick 29290 # qcom/sepolicy m7 workaround
repopick 29291 # display/8974 allow 8960
repopick 29294 # msm8960: Allow liblight override
repopick 32756 # display-8974: use libhwui instead of libskia

repopick 32817 # twrp: remove unused variable
repopick 32819 # twrp: Fix missing dependencie

repopick -t extract_elf_ramdisk_LZMA 

cd ~/build/make
echo -e ${YELLOW}"-----Patching $PWD"${NC}
# pick rsync recovery patch
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_build refs/changes/95/29895/2 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
repopick 27639
repopick 27640


V_URI=https://gerrit.omnirom.org

V_REPO=android_device_sony_msm8974-common
V_PATH=device/sony/msm8974-common
V_EXCLUDE="\"28083\""
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
