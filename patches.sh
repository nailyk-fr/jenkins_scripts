#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/vendor/cm
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,UNOFFICIAL,'${PICKLINEAGE}',g' config/common.mk

cd ~/

source ./build/envsetup.sh

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/

cd ~/device/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-13.0
#git fetch github cm-13.0_twrp
git checkout github/cm-13.0
#git checkout github/cm-13.0_twrp
cd ~/
repopick -Q "status:open+project:android_device_samsung_tuna+branch:cm-13.0" -g https://gerrit.nailyk.fr -P device/samsung/tuna

cd ~/device/samsung/maguro
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-13.0
#git fetch github cm-13.0_twrp
git checkout github/cm-13.0
#git checkout github/cm-13.0_twrp
cd ~/
repopick -Q "status:open+project:android_device_samsung_maguro+branch:cm-13.0" -g https://gerrit.nailyk.fr -P device/samsung/maguro

cd ~/kernel/samsung/tuna
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-13.0
git checkout github/cm-13.0
cd ~/
repopick -Q "status:open+branch:cm-13.0+project:LineageOS/android_kernel_samsung_tuna+branch:cm-13.0" -P kernel/samsung/tuna

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github cm-13.0
git checkout github/cm-13.0
cd ~/
repopick -Q "status:open+project:proprietary_vendor_samsung+branch:cm-13.0" -g https://gerrit.nailyk.fr -P vendor/samsung

cd ~/vendor/ti
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git fetch github master
git checkout github/master
cd ~/
repopick -Q "status:open+project:proprietary_vendor_ti+branch:cm-13.0" -g https://gerrit.nailyk.fr -P vendor/ti

echo -e ${GREEN}"-----Grabing global patches"${NC}
sed -i "s/.secure=1/.secure=0/g" vendor/cm/config/common.mk 
sed -i "s/.secure=1/.secure=0/g" build/core/main.mk 

echo -e ${GREEN}"-----Patching done --------------"${NC}

