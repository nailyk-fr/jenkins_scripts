#!/bin/bash

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

echo -e ${GREEN}"---------home set to: $HOME"${NC}
echo -e ${GREEN}"Lets merge LineageOS"${NC}

# list of device paths + branch to fetch/checkout
# the order specified here is the order being processed
# format: FULLPATH:BRANCH (e.g.: /home/foo/bar:master)
DEVPATHS="$HOME/vendor/sony:android-8.0 \
          "

# merge
F_MERGE(){
  MERGPATH=$1
  [ ! -d "$MERGPATH" ] && echo "ERROR: cannot find path specified ($MERGPATH)" && exit 3
  cd $MERGPATH
  BRANCH="$2"
  echo -e ${YELLOW}"-----Merging $PWD"${NC}
  git fetch gerrit android-8.0
  git fetch omnirom $BRANCH
  git checkout gerrit/android-8.0
  git merge omnirom/$BRANCH --no-edit
  git push gerrit HEAD:${BRANCH}
}

# do a merge for any defined path
for merge in $DEVPATHS;do
  F_MERGE "${merge/:*/}" "${merge/*:/}"
done
