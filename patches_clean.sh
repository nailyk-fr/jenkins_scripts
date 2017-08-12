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
git checkout github/cm-13.0

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0

cd ~/vendor/ti
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/master

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/android-6.0

cd ~/device/samsung/maguro
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0

cd ~/device/samsung/tuna
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0

cd ~/kernel/samsung/tuna
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0

cd ~/system/core
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0

cd ~/system/vold
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/cm-13.0


cd ~/

echo -e ${GREEN}"-----Cleaning done $PWD"${NC}
