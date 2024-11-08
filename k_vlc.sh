. $MYFOLDER/env.sh

cd ~/apps/vlc-android

export ANDROID_SDK=/var/jenkins_home/SDK
export ANDROID_NDK=/var/jenkins_home/android-ndk-r18b

echo "--------------- compile armeabi-v7a"
sed -i 's/STOREALIAS="vlc"/STOREALIAS="fdroid"/g' ./compile.sh
sed -i 's/MEDIALIBRARY_HASH=082216a/MEDIALIBRARY_HASH=d8a2d010/g' ./compile-libvlc.sh
sh ./buildsystem/compile.sh -a armeabi-v7a --signrelease
echo "--------------- copy"
cp -v ./vlc-android/build/outputs/apk/vanillaARMv7/signedRelease/VLC-Android-*.apk ~/fdroiddata/repo/vlc.apk
