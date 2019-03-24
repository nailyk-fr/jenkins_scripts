#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"
BRANCH="lineage-15.1"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/
source ./build/envsetup.sh
echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching toolchain .o0o. .o0o..o0o..o0o."${NC}
echo -e ${YELLOW}"-----Picking system wide commits"${NC}

cd ~/hardware/samsung_slsi-cm/exynos
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_hardware_samsung_slsi-cm_exynos+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P hardware/samsung_slsi-cm/exynos

cd ~/hardware/samsung_slsi-cm/exynos5
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_hardware_samsung_slsi-cm_exynos5+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P hardware/samsung_slsi-cm/exynos5

cd ~/hardware/samsung_slsi-cm/exynos7870
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_hardware_samsung_slsi-cm_exynos7870+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P hardware/samsung_slsi-cm/exynos7870

cd ~/hardware/samsung_slsi-cm/openmax
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_hardware_samsung_slsi-cm_openmax+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P hardware/samsung_slsi-cm/openmax

cd ~/device/samsung/exynos7870-common
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_exynos7870-common+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P device/samsung/exynos7870-common

cd ~/device/samsung/j5y17lte
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_device_samsung_j5y17lte+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P device/samsung/j5y17lte

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching kernels .o0o. .o0o..o0o..o0o."${NC}

cd ~/kernel/samsung/exynos7870
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_kernel_samsung_exynos7870+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P kernel/samsung/exynos7870

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching vendors .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Patching $PWD"${NC}
cd ~/
$MYFOLDER/repopick.py -Q "NOT+label:Code-Review=-2+AND+NOT+label:Verified=-1+(status:open+project:android_vendor_samsung+branch:${BRANCH})"  -g https://gerrit.nailyk.fr -P vendor/samsung

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/lineage
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,UNOFFICIAL,'${PICKOFFICIAL}',g' config/common.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
cp $MYFOLDER/df9b0574.0 ~/system/ca-certificates/files/df9b0574.0

echo -e ${GREEN}"-----Patching done --------------"${NC}
