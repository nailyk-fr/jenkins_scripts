#!/bin/bash

export USER=jenkins
export LANG=C
export USE_NINJA=false
export WITH_SU=true
MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/functions.sh

BRANCH=android-9.0

echo -e ${GREEN}"---------home set to: $HOME"${NC}

cleanup_wrapper () {

  V_REPO=$2
  V_PATH=~/${1}

  cleanup_repo

  # Ensure variable does not persist
  unset V_REPO
  unset V_REPO

}


for a_repo in bionic system/core build/soong build/make vendor/omni system/vold packages/apps/OpenDelta packages/apps/Messaging packages/apps/Dialer packages/apps/OmniClock packages/apps/Settings external/mksh hardware/interfaces hardware/libhardware hardware/qcom/gps hardware/qcom/media-caf-msm8974 hardware/qcom/audio-caf-msm8974 hardware/sony/macaddrsetup frameworks/base bootable/recovery frameworks/av system/sepolicy device/sony/shinano-common device/sony/msm8974-common device/sony/common-init kernel/sony/msm8974 device/qcom/sepolicy packages/apps/Phonograph device/sony/z3 device/sony/z3c device/sony/z2
do 
  cleanup_wrapper ${a_repo} omnirom/${BRANCH}
done

for a_repo in vendor/sony vendor/qcom/opensource/dataservices device/sony/yoshino device/sony/lilac device/sony/common-treble kernel/sony/msm8998
do
  cleanup_wrapper ${a_repo} github/${BRANCH}
done


