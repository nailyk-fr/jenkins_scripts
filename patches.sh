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
repopick 27694 # twrp: Remove APP
repopick 28631 # twrp: scrypt <machine/cpu-features.h>.
repopick 27792 # twrp: ext4: force keymaster v1 (Probably useless as is for FBE)

repopick 29290 # qcom/sepolicy m7 workaround
repopick 29291 # display/8974 allow 8960
repopick 29294 # msm8960: Allow liblight override

repopick 32808 # Fix download provider missing SqlSelection type

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

cd ~/device/samsung/j5y17lte
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.nailyk.fr -P device/samsung/j5y17lte -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_j5y17lte+branch:android-8.1)"

cd ~/device/samsung/exynos7870-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -g https://gerrit.nailyk.fr -P device/samsung/exynos7870-common -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_exynos7870-common+branch:android-8.1)"

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching kernels .o0o. .o0o..o0o..o0o."${NC}

cd ~/kernel/sony/msm8974
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_sony_msm8974+branch:android-8.1)"  -g https://gerrit.omnirom.org -P kernel/sony/msm8974

cd ~/kernel/samsung/exynos7870
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_samsung_exynos7870+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P kernel/samsung/exynos7870

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching vendors .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/sony
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:omni_vendor_sony+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P vendor/sony

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_vendor_samsung+branch:android-8.1)"  -g https://gerrit.nailyk.fr -P vendor/samsung

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/omni
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/version.mk
sed -i 's,HOMEMADE,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}
