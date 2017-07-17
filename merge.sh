cd ~/device/sony/z3dual
git fetch gerrit cm-14.1_twrp
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1_twrp
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1_twrp

cd ~/device/sony/z3
git fetch gerrit cm-14.1_twrp
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1_twrp
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1_twrp

cd ~/device/sony/z3c
git fetch gerrit cm-14.1_twrp
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1_twrp
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1_twrp

cd ~/device/sony/shinano-common
git fetch gerrit cm-14.1
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1

cd ~/device/sony/msm8974-common
git fetch gerrit cm-14.1
git fetch lineage cm-14.1
git checkout gerrit/cm-14.1
git merge lineage/cm-14.1 --no-edit
git push gerrit HEAD:cm-14.1
