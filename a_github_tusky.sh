export HOME=/var/jenkins_home/workspace/F-Droid/
echo "--------- home set"

set -e

echo ${GREEN}"--------------------- preparing env "${NC}

MYFOLDER="$(dirname "$(realpath "$0")")"
. $MYFOLDER/colors.sh

export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH

export USER=jenkins
export ANDROID_HOME=/var/jenkins_home/SDK
export GRADLE_USER_HOME=$HOME
export NDK_PROJECT_PATH=/var/jenkins_home/NDK/android-ndk-r13b

export LANG=C.UTF-8
unset _JAVA_OPTIONS
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"


echo ${GREEN}"--------------------- patching sources "${NC}

# Inside the auto triggered script. So workspace is the root folder of the git clone
cd ${WORKSPACE}

cat "/var/jenkins_home/workspace/F-Droid/.signing" >> app/gradle.properties
echo "
android {
    signingConfigs {
       release {
           storeFile file(RELEASE_STORE_FILE)
           storePassword RELEASE_STORE_PASSWORD
           keyAlias RELEASE_KEY_ALIAS
           keyPassword RELEASE_KEY_PASSWORD
       }
    }
    buildTypes {
            release {
                signingConfig signingConfigs.release
            }
    }
}" >> app/build.gradle

echo ${GREEN}"--------------------- building "${NC}

echo "---- cleaning"
rm -rf build app/build .gradle || true

APP_PROJECT_PATH=$PWD/app/src/main \
NDK_PROJECT_PATH=$PWD/app/src/main \
APP_BUILD_SCRIPT=$PWD/app/src/main/jni/Android.mk \
./gradlew assembleRelease
./gradlew --stop || true
killall aapt || true
cp -v app/build/outputs/apk/green/release/Tusky_*_green_release.apk ~/fdroiddata/repo/



echo ${GREEN}"--------------------- release "${NC}

cd ~/fdroidserver
export LC_ALL=C.UTF-8
cd ~/fdroidserver/
python -m venv fdroidserver-env
. fdroidserver-env/bin/activate
pip3 install fdroidserver
cd ~/fdroiddata/
fdroid update -v

