BUILD_VER="cm-14.1"

cd ~/.repo
if [ ! -d "$HOME/.repo/local_manifests" ]; then
  git clone https://github.com/nailyk-fr/local_manifests.git -b "${BUILD_VER}-ADC_work" local_manifests
else
  cd ~/.repo/local_manifests
  git fetch origin "${BUILD_VER}-ADC_work"
  git checkout "origin/${BUILD_VER}-ADC_work"
fi

cd ~
repo sync -j 4
echo "--------- repo sync end"
