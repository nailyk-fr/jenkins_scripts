#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

echo "---------home set to: $HOME"

cd ~/vendor/cm
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/device/qcom/sepolicy
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/system/sepolicy
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/bootable/recovery
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout github/android-7.1

cd ~/device/sony/z3
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/z3c
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/z3dual
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/sirius
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/castor_windy
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1_twrp

cd ~/device/sony/shinano-common
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/device/sony/msm8974-common
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/kernel/sony/msm8974
git reset --hard
git clean -fxd :/
git checkout github/cm-14.1

cd ~/

