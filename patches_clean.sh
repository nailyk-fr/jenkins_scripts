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
git checkout omnirom/android-8.0

cd ~/build/make
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/vendor/omni
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/packages/apps/Messaging
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/packages/apps/Dialer
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/packages/apps/OmniClock
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/hardware/interfaces
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/frameworks/base
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/frameworks/av
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/packages/apps/Phonograph
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/vendor/sony
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/device/qcom/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

#cd ~/device/sony/leodual
#echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
#git reset --hard
#git clean -fxd :/
#git checkout github/android-8.0

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

#cd ~/device/sony/castor_windy
#echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
#git reset --hard
#git clean -fxd :/
#git checkout github/android-8.0

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/kernel/ti/omap4
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-8.0

cd ~/

