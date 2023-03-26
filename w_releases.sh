export HOME=${WORKSPACE}
echo "--------- home set"

export USER=jenkins

export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH
cd ~/fdroidserver

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

cd ~/fdroidserver/
python -m venv fdroidserver-env
. fdroidserver-env/bin/activate
pip3 install fdroidserver
cd ~/fdroiddata/
fdroid update -v
