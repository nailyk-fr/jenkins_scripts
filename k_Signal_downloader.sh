#!/bin/bash

###### All the bad Jenkins hack I made
export HOME=/var/jenkins_home/workspace/F-Droid/
echo "--------- home set"

set -e

echo ${GREEN}"--------------------- preparing env "${NC}

MYFOLDER="$(dirname "$(realpath "$0")")"
. $MYFOLDER/colors.sh
. $MYFOLDER/env.sh

export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH

echo ${GREEN}"--------------------- Downloading "${NC}

# Inside the auto triggered script. So workspace is the root folder of the git clone
cd ${WORKSPACE}

G_FDROID_FOLDER="~/fdroiddata/repo"

##### End of - All the bad Jenkins hack I made

T_SIGNAL_LATEST_JSON=$(curl -s https://api.github.com/repos/signalapp/Signal-Android/releases/latest)

T_LATEST_FILENAME=$(echo "${T_SIGNAL_LATEST_JSON}" | jq '.assets[].name' | tr -d '"')
T_FULL_PATH="${G_FDROID_FOLDER}/${T_LATEST_FILENAME}"
T_LATEST_URL=$(echo "${T_SIGNAL_LATEST_JSON}" | jq '.assets[].browser_download_url' | tr -d '"')
T_DIGEST=$(echo "${T_SIGNAL_LATEST_JSON}" | jq '.assets[].digest' | tr -d '"' | cut -d ':' -f2)



echo "Latest Filename: ${T_LATEST_FILENAME} -- ${T_FULL_PATH}"
echo "Latest URL : ${T_LATEST_URL}"

wget --continue "${T_LATEST_URL}" -O "${T_FULL_PATH}"

echo ${GREEN}"--------------------- Digesting "${NC}


T_COMPUTE_DIGEST=$(sha256sum "${T_FULL_PATH}" | awk '{print $1}')

echo "Retrieved digest : ${T_DIGEST}"
echo "Computed digest : ${T_COMPUTE_DIGEST}"

if [[ "${T_DIGEST}" != "${T_COMPUTE_DIGEST}" ]]; then
  echo "There was an issue downloading the file. Removing..."
  rm -v "${T_FULL_PATH}"
  exit 1 # Exit with error code to mark the build status to fail in Jenkins
fi
