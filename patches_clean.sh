#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

echo "---------home set to: $HOME"

cd ~/vendor/omni
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/vendor/sony
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout choosea/android-7.1

cd ~/device/qcom/sepolicy
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/system/sepolicy
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/bootable/recovery
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout omnirom/android-7.1

cd ~/device/sony/leo
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

#cd ~/device/sony/aries
#echo "-----Cleaning $PWD"
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

#cd ~/device/sony/leodual
#echo "-----Cleaning $PWD"
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

#cd ~/device/sony/sirius
#echo "-----Cleaning $PWD"
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

#cd ~/device/sony/castor_windy
#echo "-----Cleaning $PWD"
#git reset --hard
#git clean -fxd :/
#git checkout github/android-7.1

cd ~/device/sony/shinano-common
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

cd ~/device/sony/msm8974-common
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

cd ~/kernel/sony/msm8974
echo "-----Cleaning $PWD"
git reset --hard
git clean -fxd :/
git checkout choose/android-7.1

cd ~/

