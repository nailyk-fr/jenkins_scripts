BUILD_VER="android-9.0"
LOCAL_BRANCH="${BUILD_VER}"

echo -e ${GREEN}".o0o. .o0o..o0o..o0o. syncing repos .o0o. .o0o..o0o..o0o."${NC}

cd ~
repo sync --force-sync -j 8
echo "--------- repo sync end"
