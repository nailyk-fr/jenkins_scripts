. $MYFOLDER/env.sh

cd ~/apps/Osmand

APP_PROJECT_PATH=$PWD/OsmAnd \
NDK_PROJECT_PATH=$PWD/OsmAnd \
APP_BUILD_SCRIPT=$PWD/OsmAnd/jni/Android.mk \
./gradlew assembleRelease
./gradlew --stop || true
killall aapt || true
cp -v app/build/outputs/apk/app-release.apk ~/fdroiddata/repo/AndroidVTS.apk
