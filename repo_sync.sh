BUILD_VER="cm-12.1"

cd ~/.repo
if [ ! -d "$HOME/.repo/local_manifests" ]; then
  git clone https://github.com/nailyk-fr/local_manifests.git -b "${BUILD_VER}_staging" local_manifests
else
  cd ~/.repo/local_manifests
  git fetch origin "${BUILD_VER}_staging"
  git checkout "origin/${BUILD_VER}_staging"
fi

cd ~
repo sync -j 4
echo "--------- repo sync end"
