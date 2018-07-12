export USER=jenkins
export ANDROID_HOME=/var/jenkins_home/SDK
export GRADLE_USER_HOME=$HOME
export NDK_PROJECT_PATH=/var/jenkins_home/NDK/android-ndk-r13b

export LANG=C
unset _JAVA_OPTIONS
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"


cd ~/apps/mGerrit/

APP_PROJECT_PATH=$PWD/app/src/main \
NDK_PROJECT_PATH=$PWD/app/src/main \
APP_BUILD_SCRIPT=$PWD/app/src/main/jni/Android.mk \
./gradlew assembleRelease
./gradlew --stop || true
killall aapt || true
cp -v app/build/outputs/apk/app-noAnalytics-release.apk ~/fdroiddata/repo/mGerrit-noAnalytics.apk
