export ANDROID_HOME=/var/jenkins_home/SDK
export GRADLE_USER_HOME=$HOME
export NDK_PROJECT_PATH=/var/jenkins_home/NDK/android-ndk-r13b

export LANG=C
unset _JAVA_OPTIONS
export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
export ANDROID_JACK_VM_ARGS="$JACK_SERVER_VM_ARGUMENTS"


cd ~/apps/vlc-android

export ANDROID_SDK=/var/jenkins_home/SDK
export ANDROID_NDK=/var/jenkins_home/NDK/android-ndk-r13b

echo "--------------- compile armeabi-v7a"
sh ./compile.sh -a armeabi-v7a --signrelease
#echo "--------------- compile release"
#sh ./compile.sh
echo "--------------- copy"
cp ./vlc-android/build/outputs/apk/VLC-Android-*.apk ~/fdroiddata/repo/vlc.apk
