#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD

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

cd ~/

