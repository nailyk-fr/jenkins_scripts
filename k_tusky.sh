. $MYFOLDER/env.sh

cd ~/apps/Tusky/

echo "---- cleaning"
rm -rf build app/build .gradle

APP_PROJECT_PATH=$PWD/app/src/main \
NDK_PROJECT_PATH=$PWD/app/src/main \
APP_BUILD_SCRIPT=$PWD/app/src/main/jni/Android.mk \
./gradlew assembleRelease
./gradlew --stop || true
killall aapt || true
cp -v app/build/outputs/apk/blue/release/Tusky_*_blue_release.apk ~/fdroiddata/repo/Tusky.apk
