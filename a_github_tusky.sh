export HOME=/var/jenkins_home/workspace/F-Droid/
echo "--------- home set"

echo -e ${GREEN}"--------------------- preparing env "${NC}

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH

export USER=jenkins
export ANDROID_HOME=/var/jenkins_home/SDK
export GRADLE_USER_HOME=$HOME
export NDK_PROJECT_PATH=/var/jenkins_home/NDK/android-ndk-r13b

export LANG=C
unset _JAVA_OPTIONS
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"


echo -e ${GREEN}"--------------------- patching sources "${NC}

# Inside the auto triggered script. So workspace is the root folder of the git clone
cd ${WORKSPACE}

wget "https://raw.githubusercontent.com/nailyk-fr/jenkins_scripts/nougat-mr1.1-release/patches/AndroidVTS.properties" -O local.properties
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

echo -e ${GREEN}"--------------------- building "${NC}

APP_PROJECT_PATH=$PWD/app/src/main \
NDK_PROJECT_PATH=$PWD/app/src/main \
APP_BUILD_SCRIPT=$PWD/app/src/main/jni/Android.mk \
./gradlew assembleRelease
./gradlew --stop || true
killall aapt || true
cp -v app/build/outputs/apk/blue/release/app-blue-release.apk ~/fdroiddata/repo/Tusky.apk
cp -v app/build/outputs/apk/green/release/app-green-release.apk ~/fdroiddata/repo/Tusky-debug.apk



echo -e ${GREEN}"--------------------- release "${NC}

cd ~/fdroidserver
 . env/bin/activate
echo dans env:
pip3 install --upgrade pyparsing
pip3 install --upgrade appdirs
pip3 install --upgrade backports.ssl_match_hostname
pip3 install --upgrade  cryptography
pip3 install -e .
cd ~/fdroiddata/
fdroid update -v

