#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER=$PWD/scripts

echo "---------home set to: $HOME"

cd ~/vendor/cm
echo "-----Patching $PWD"
sed -i 's,UNOFFICIAL,nailyk,g' config/common.mk

cd ~/

