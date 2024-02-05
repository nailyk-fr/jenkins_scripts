export HOME=${WORKSPACE}
echo "--------- home set"

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

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

cd ~/fdroidserver/
python -m venv fdroidserver-env
. fdroidserver-env/bin/activate
pip install git+https://gitlab.com/fdroid/fdroidserver.git
cd ~/fdroiddata/
fdroid update -v
