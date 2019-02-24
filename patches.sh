#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"
BRANCH="android-9.0"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/
source ./build/envsetup.sh
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching toolchain .o0o. .o0o..o0o..o0o."${NC}
echo -e ${YELLOW}"-----Picking system wide commits"${NC}
repopick 27693 # twrp: Cleanup flags
repopick 27694 # twrp: Remove APP
repopick 28631 # twrp: scrypt <machine/cpu-features.h>.
repopick 27792 # twrp: ext4: force keymaster v1 (Probably useless as is for FBE)
repopick 32479
repopick 32480 # twrp: fix vndk for arm32
repopick 32481
repopick 32482
repopick 32483
repopick 32636 # twrp: fix dosfstools on arm32
repopick 32647
repopick 32648
repopick 32714

repopick 29290 # qcom/sepolicy m7 workaround
repopick 29291 # display/8974 allow 8960
repopick 29294 # msm8960: Allow liblight override
repopick 32756 # display-8974: use libhwui instead of libskia

repopick 32817 # twrp: remove unused variable
repopick 32819 # twrp: Fix missing dependencie

repopick -t legacy-cam-8.1 # fmwk/av

repopick -t extract_elf_ramdisk_LZMA 

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
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:device_htc_m7+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P device/htc/m7

cd ~/device/htc/m7-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:device_htc_m7-common+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P device/htc/m7-common

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching shinano .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/sony/msm8974-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_msm8974-common+branch:${BRANCH})"  -g https://gerrit.omnirom.org -P device/sony/msm8974-common --exclude "28083,28163,29654,29655,29656,29657,29625,29624"

cd ~/device/sony/shinano-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_shinano-common+branch:${BRANCH})"  -g https://gerrit.omnirom.org -P device/sony/shinano-common

cd ~/device/sony/z3
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3+branch:${BRANCH})"  -g https://gerrit.omnirom.org -P device/sony/z3

cd ~/device/sony/z3c
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z3c+branch:${BRANCH})"  -g https://gerrit.omnirom.org -P device/sony/z3c

cd ~/device/sony/z2
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_z2+branch:${BRANCH})"  -g https://gerrit.omnirom.org -P device/sony/z2

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching kanuti .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/sony/kanuti
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_kanuti+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P device/sony/kanuti

cd ~/device/sony/m4aqua
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_sony_m4aqua+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P device/sony/m4aqua

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching oneplus .o0o. .o0o..o0o..o0o."${NC}

cd ~/device/oneplus/oneplus5
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/oneplus/oneplus5 -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_oneplus_oneplus5+branch:${BRANCH})" --exclude "27415,29465"

cd ~/device/oneplus/oneplus5t
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P device/oneplus/oneplus5t -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_oneplus_oneplus5t+branch:${BRANCH})" --exclude "28861"

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching kernels .o0o. .o0o..o0o..o0o."${NC}

cd ~/kernel/htc/msm8960
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_htc_msm8960+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P kernel/htc/msm8960

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm8974+branch:${BRANCH})"  -g https://gerrit.omnirom.org -P kernel/sony/msm8974

cd ~/kernel/oneplus/msm8998
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.omnirom.org -P kernel/oneplus/msm8998  -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_oneplus_msm8998+branch:${BRANCH})" 

#cd ~/kernel/sony/msm
#echo -e ${YELLOW}"-----Patching $PWD"${NC}
#cd ~/
#$MYFOLDER/repopick.py -g https://gerrit.nailyk.fr -P kernel/sony/msm8  -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm+branch:${BRANCH})" 

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching vendors .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/sony
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:omni_vendor_sony+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P vendor/sony

cd ~/vendor/htc
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:proprietary_vendor_htc+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P vendor/htc

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/version.mk
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}
