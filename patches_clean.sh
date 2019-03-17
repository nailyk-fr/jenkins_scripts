#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh

BRANCH=lineage-15.1

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cd ~/system/core
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/build/soong
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/build/make
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/vendor/lineage
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/system/vold
echo -e ${YELLOW}"-----Patching $PWD"${NC}
git reset --hard
git fetch github ${BRANCH}
git checkout github/${BRANCH}

cd ~/hardware/interfaces
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/hardware/libhardware
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/hardware/samsung
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/hardware/samsung_slsi-cm/exynos
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/hardware/samsung_slsi-cm/exynos5
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/hardware/samsung_slsi-cm/exynos7870
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/hardware/samsung_slsi-cm/openmax
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/frameworks/base
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/frameworks/av
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/vendor/samsung
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/system/sepolicy
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/${BRANCH}

cd ~/bootable/recovery
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout github/android-8.1

cd ~/device/samsung/exynos7870-common
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/device/samsung/j5y17lte
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/kernel/samsung/exynos7870
echo -e ${YELLOW}"-----Cleaning $PWD"${NC}
git reset --hard
git clean -fxd :/
git checkout carbon-fusion/${BRANCH}

cd ~/

