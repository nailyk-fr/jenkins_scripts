#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/vendor/sony
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout choosea/android-7.1

cd ~/device/qcom/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/device/sony/leo
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

#cd ~/device/sony/aries
#echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

#cd ~/device/sony/leodual
#echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

#cd ~/device/sony/sirius
#echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

#cd ~/device/sony/castor_windy
#echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

cd ~/

