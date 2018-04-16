#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/
source ./build/envsetup.sh
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching toolchain .o0o. .o0o..o0o..o0o."${NC}
echo -e ${YELLOW}"-----Picking system wide commits"${NC}
repopick 27693 # twrp: Cleanup flags
repopick 27694 # twrp: Remove APP
repopick 28056 # twrp: toybox: Fix build for android 8.1
repopick 28631 # twrp: scrypt <machine/cpu-features.h>.
repopick 27792 # twrp: ext4: force keymaster v1 (Probably useless as is for FBE)

repopick -t unifiednlp # fmwk/base & vendor/omni

repopick 29290 # qcom/sepolicy m7 workaround
repopick 29291 # display/8974 allow 8960
repopick 29294 # msm8960: Allow liblight override

repopick -t legacy-cam-8.1 # fmwk/av

repopick -t extract_elf_ramdisk_LZMA 

repopick 29411 # Add audio amplifier HAL

cd ~/build/make
echo -e ${YELLOW}"-----Patching $PWD"${NC}
# pick rsync recovery patch
git fetch ssh://nailyk@gerrit.omnirom.org:29418/android_build refs/changes/95/29895/2 && git cherry-pick FETCH_HEAD
cd ~/

cd ~/packages/apps/OpenDelta
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
repopick 27639
repopick 27640

cd ~/hardware/qcom/gps
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
repopick 29660 # Allow msm8916

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching HTC .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/htc/m7
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:device_htc_m7+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P device/htc/m7

cd ~/device/htc/m7-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:device_htc_m7-common+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P device/htc/m7-common

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching shinano .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/msm8974-common --exclude "28083,28163,29654,29655,29656,29657,29625,29624"

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/shinano-common

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/z3

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3c+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/z3c

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z2+branch:android-8.1)"  -g https://gerrit.omnirom.org -P device/sony/z2

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching kanuti .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/sony/kanuti
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_kanuti+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P device/sony/kanuti

cd ~/device/sony/m4aqua
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_m4aqua+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P device/sony/m4aqua

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching oneplus .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/oneplus/oneplus5
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/oneplus/oneplus5 -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_oneplus_oneplus5+branch:android-8.1)" --exclude "27415,29465"

cd ~/device/oneplus/oneplus5t
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/oneplus/oneplus5t -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_oneplus_oneplus5t+branch:android-8.1)" --exclude "28861"

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching kernels .o0o. .o0o..o0o..o0o."${NC}

cd ~/kernel/htc/msm8960
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_htc_msm8960+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P kernel/htc/msm8960

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm8974+branch:android-8.1)"  -g https://gerrit.omnirom.org -P kernel/sony/msm8974

cd ~/kernel/oneplus/msm8998
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P kernel/oneplus/msm8998  -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_oneplus_msm8998+branch:android-8.1)" 

#cd ~/kernel/sony/msm
#echo -e ${YELLOW}"-----Patching $PWD"${NC}
#cd ~/
#$MYFOLDER/repopick.py -g https://gerrit.nailyk.fr -P kernel/sony/msm8  -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm+branch:android-8.1)" 

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching vendors .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/sony
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:omni_vendor_sony+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P vendor/sony

cd ~/vendor/htc
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:proprietary_vendor_htc+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P vendor/htc

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/version.mk
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}
