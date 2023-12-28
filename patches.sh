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


echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching for MicroG .o0o. .o0o..o0o..o0o."${NC}
# Documentation : https://github.com/microg/GmsCore/wiki/Signature-Spoofing
cd ~/frameworks/base
wget -O- -q "https://github.com/lineageos4microg/docker-lineage-cicd/raw/master/src/signature_spoofing_patches/android_frameworks_base-S.patch" | patch -p1 --batch --forward
echo "Removing backup files created by patch: "
find . -type f -name "*.orig" -delete -print

cd ~/packages/modules/Permissions
wget -O- -q "https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/packages_modules_Permission-Android13.patch" | patch -p1 --batch --forward
echo "Removing backup files created by patch: "
find . -type f -name "*.orig" -delete -print


echo -e ${GREEN}".o0o. .o0o..o0o..o0o. f-droid .o0o. .o0o..o0o..o0o."${NC}
cd ~/vendor/fdroid
if [[ ! -f proprietary/app/org.fdroid.fdroid_1015053.apk ]]; then
  git reset --hard
  sed -i 's,1000013,1015053,g' repo/fdroid.txt
  ./get_packages.sh
fi

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. Patching customizations .o0o. .o0o..o0o..o0o."${NC}

cd ~/vendor/lineage
echo -e ${YELLOW}"-----Patching $PWD"${NC}
sed -i 's,UNOFFICIAL,'${PICKOFFICIAL}',g' config/version.mk

cd ~/
echo -e ${GREEN}"-----coping nailyk CA"${NC}
# openssl x509 -in nailyk.crt -noout -subject_hash_old
cp $MYFOLDER/878504ee.0 ~/system/ca-certificates/files/878504ee.0

if [[ ${UNSECURE:-} ]]
then
	echo -e ${RED}".o0o. .o0o..o0o..o0o. make build unsecure .o0o. .o0o..o0o..o0o."${NC}
	sed -i 's/ro.adb.secure=./ro.adb.secure=0/g' vendor/omni/config/common.mk 
	sed -i 's/ro.adb.secure=./ro.adb.secure=0/g' build/core/main.mk 
	sed -i 's/ro.secure=./ro.secure=0/g' build/core/main.mk 
fi

echo -e ${GREEN}"-----Patching done --------------"${NC}

HOME=$V_OLDHOME
