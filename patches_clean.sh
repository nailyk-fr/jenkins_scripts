#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

BRANCH=android-9.0

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/system/core
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/build/soong
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/build/make
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/system/vold
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch omnirom ${BRANCH}
git checkout omnirom/${BRANCH}
cd ~/

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/packages/apps/Messaging
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout aosp/${BRANCH}

cd ~/packages/apps/Dialer
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/packages/apps/OmniClock
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/packages/apps/Settings
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/external/mksh
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/hardware/interfaces
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/hardware/libhardware
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/hardware/qcom/gps
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/hardware/qcom/media-caf-msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/hardware/qcom/audio-caf-msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/hardware/sony/macaddrsetup
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/frameworks/base
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/frameworks/av
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/packages/apps/Phonograph
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/vendor/sony
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/vendor/qcom/opensource/dataservices
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/device/qcom/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/common-init
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/${BRANCH}

cd ~/device/sony/yoshino
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/device/sony/lilac
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/device/sony/common-treble
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/kernel/sony/msm8998
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/

