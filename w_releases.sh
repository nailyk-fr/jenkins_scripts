export HOME=${WORKSPACE}
echo "--------- home set"

export USER=jenkins

export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH
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

