. $MYFOLDER/env.sh

cd ~/apps/mGerrit/

APP_PROJECT_PATH=$PWD/app/src/main \
NDK_PROJECT_PATH=$PWD/app/src/main \
APP_BUILD_SCRIPT=$PWD/app/src/main/jni/Android.mk \
./gradlew assembleRelease
./gradlew --stop || true
killall aapt || true
cp -v app/build/outputs/apk/app-noAnalytics-release.apk ~/fdroiddata/repo/mGerrit-noAnalytics.apk
