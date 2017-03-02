BUILD_VER="cm-14.1"
LOCAL_BRANCH="${BUILD_VER}-stockCM"

cd ~/.repo
if [ ! -d "$HOME/.repo/local_manifests" ]; then
  git clone https://github.com/nailyk-fr/local_manifests.git -b ${LOCAL_BRANCH} local_manifests
else
  cd ~/.repo/local_manifests
  git fetch origin ${LOCAL_BRANCH}
  git checkout "origin/${LOCAL_BRANCH}"
fi

cd ~
repo sync -j 8
echo "--------- repo sync end"
