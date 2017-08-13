#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}


cd ~/vendor/cm
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/vendor/ti
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/master

cd ~/vendor/sony
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/device/qcom/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/android-7.1

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/z3dual
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/sirius
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/castor_windy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/kernel/samsung/tuna
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/system/core
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/system/vold
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1


cd ~/

echo -e ${GREEN}"-----Cleaning done $PWD"${NC}
