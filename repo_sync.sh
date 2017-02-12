BUILD_VER="cm-14.1"

cd ~/.repo
if [ ! -d "$HOME/.repo/local_manifests" ]; then
  git clone https://github.com/nailyk-fr/local_manifests.git -b "${BUILD_VER}-ADC_z317" local_manifests
else
  cd ~/.repo/local_manifests
  git fetch origin "${BUILD_VER}-ADC_z317"
  git checkout "origin/${BUILD_VER}-ADC_z317"
fi

cd ~
repo sync -j 4
echo "--------- repo sync end"
