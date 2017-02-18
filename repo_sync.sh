BUILD_VER="nougat-mr1.1-release"

cd ~/.repo
if [ ! -d "$HOME/.repo/local_manifests" ]; then
  git clone https://github.com/nailyk-fr/android_manifest.git -b "${BUILD_VER}_staging" local_manifests
else
  cd ~/.repo/local_manifests
  git fetch origin "${BUILD_VER}_staging"
  git checkout "origin/${BUILD_VER}_staging"
fi

cd ~/system/sepolicy
git reset --hard
git clean -fxd :/
echo "--------sepolicies cleaned"

cd ~/packages/apps/F-Droid
git reset --hard
git clean -fxd :/
echo "--------F-droid cleaned"

cd ~/kernel/lge/hammerhead
git reset --hard
git clean -fxd :/
echo "--------kernel cleaned"

cd ~/packages/apps/AndroidVTS/
git reset --hard
git clean -fxd :/
echo "--------AndroidVTS cleaned"

cd ~
repo sync -j 8 --force-sync
echo "--------- repo sync end"

cd ~/system/sepolicy
git checkout "github/${BUILD_VER}"
patch -p1 < ~/device/lge/hammerhead/patches/system_sepolicy.patch
echo "--------sepolicyes patched"

cd ~/packages/apps/F-Droid
git checkout "github/${BUILD_VER}"
patch -p1 < ~/scripts/patches/fdroid.diff
echo "--------F-droid patched"

cd ~/kernel/lge/hammerhead
git checkout "github/cm-14.1"
patch -p1 < ~/device/lge/hammerhead/patches/kernel.diff
echo "--------kernel patched"

cd ~/packages/apps/AndroidVTS/
git checkout "github/master"
cp ~/scripts/patches/AndroidVTS.mk ~/packages/apps/AndroidVTS/Android.mk
cp ~/scripts/patches/AndroidVTS.properties ~/packages/apps/AndroidVTS/local.properties
echo "--------AndroidVTS patched"
