
export USER=jenkins


export PATH=/var/jenkins_home/workspace/F-Droid/fdroidserver:$PATH
cd ~/fdroidserver
git fetch origin master
git checkout origin/master
