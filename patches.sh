#!/bin/bash

V_OLDHOME=$HOME
HOME=$PWD

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"
BRANCH="lineage-19.1"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh
source $MYFOLDER/functions.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}


cd ~/
source ./build/envsetup.sh
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching toolchain .o0o. .o0o..o0o..o0o."${NC}
echo -e ${YELLOW}"-----Picking system wide commits"${NC}

echo -e ${YELLOW}"-----Patching OpenDelta"${NC}
V_URI=https://review.lineageos.org

V_REPO=android_device_sony_voyager
V_PATH=device/sony/voyager
pick_repo

V_REPO=android_device_sony_bahamut
V_PATH=device/sony/bahamut
pick_repo

########### custom gerrit

V_URI=https://gerrit.nailyk.fr

V_REPO=android_device_sony_voyager
V_PATH=device/sony/voyager
pick_repo

V_REPO=android_device_sony_bahamut
V_PATH=device/sony/bahamut
pick_repo


echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/lineage
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,UNOFFICIAL,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

if [[ ${UNSECURE:-} ]]
then
	echo -e ${RED}".o0o. .o0o..o0o..o0o. make build unsecure .o0o. .o0o..o0o..o0o."${NC}
	sed -i 's/ro.adb.secure=./ro.adb.secure=0/g' vendor/omni/config/common.mk 
	sed -i 's/ro.adb.secure=./ro.adb.secure=0/g' build/core/main.mk 
	sed -i 's/ro.secure=./ro.secure=0/g' build/core/main.mk 
fi

echo -e ${GREEN}"-----Patching done --------------"${NC}

HOME=$V_OLDHOME
