#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/functions.sh

BRANCH=lineage-19.1

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cleanup_wrapper () {

  V_REPO=$2
  V_PATH=~/${1}

  cleanup_repo

  # Ensure variable does not persist
  unset V_REPO
  unset V_REPO

}


for a_repo in bionic system/core build/soong build/make vendor/omni system/vold packages/apps/Messaging packages/apps/Dialer packages/apps/Settings external/mksh hardware/interfaces hardware/libhardware hardware/qcom/gps hardware/sony/macaddrsetup frameworks/base bootable/recovery frameworks/av system/sepolicy device/qcom/sepolicy packages/apps/Phonograph device/sony/bahamut device/sony/voyager
do 
  cleanup_wrapper ${a_repo} github/${BRANCH}
done



