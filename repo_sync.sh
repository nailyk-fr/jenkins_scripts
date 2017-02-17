BUILD_VER="nougat-mr1.1-release"

cd ~/.repo
if [ ! -d "$HOME/.repo/local_manifests" ]; then
  git clone https://github.com/nailyk-fr/android_manifest.git -b "${BUILD_VER}_staging" local_manifests
else
  cd ~/.repo/local_manifests
  git fetch origin "${BUILD_VER}_staging"
  git checkout "origin/${BUILD_VER}_staging"
fi

cd ~
repo sync -j 8 --force-sync
echo "--------- repo sync end"
