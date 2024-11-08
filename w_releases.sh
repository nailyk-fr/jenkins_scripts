export HOME=${WORKSPACE}
echo "--------- home set"

echo ${GREEN}"--------------------- preparing env "${NC}

MYFOLDER="$(dirname "$(realpath "$0")")"
. $MYFOLDER/colors.sh
. $MYFOLDER/env.sh

export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

cd ~/fdroidserver/
python -m venv fdroidserver-env
. fdroidserver-env/bin/activate
pip install git+https://gitlab.com/fdroid/fdroidserver.git
cd ~/fdroiddata/
fdroid update -v
