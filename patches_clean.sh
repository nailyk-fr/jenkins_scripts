#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/system/core
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/build/make
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/vendor/omni
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/packages/apps/Messaging
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout aosp/android-8.1

cd ~/packages/apps/Dialer
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/packages/apps/OmniClock
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/external/mksh
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/hardware/interfaces
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/hardware/qcom/media-caf-msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1


cd ~/hardware/qcom/audio-caf-msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/frameworks/base
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/frameworks/av
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/packages/apps/Phonograph
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/vendor/sony
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/android-8.1

cd ~/vendor/qcom/opensource/dataservices
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/android-8.1

cd ~/device/qcom/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/oneplus/oneplus5
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/oneplus/oneplus5t
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/kernel/oneplus/msm8998
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.1

cd ~/

