#!/bin/bash

# Script to generate delta files for OpenDelta - by Jorrit 'Chainfire' Jongma

# Get device either from $DEVICE set by calling script, or first parameter

MYFOLDER="$(dirname "$(realpath "$0")")"

source $MYFOLDER/colors.sh
source $MYFOLDER/config.sh

if [ "$DEVICE" == "" ]; then
	if [ "$1" != "" ]; then
		DEVICE=$1
	fi
fi

if [ "$DEVICE" == "" ]; then
	echo -e ${RED}"Abort: no device set"${NC} >&2
	exit 1
fi

# ------ CONFIGURATION ------

HOME=$HOME

echo -e ${GREEN}"---------home set to: $HOME"${NC}

BIN_JAVA=java
BIN_MINSIGNAPK=$HOME/packages/apps/OpenDelta/server/minsignapk.jar
BIN_XDELTA=$MYFOLDER/xdelta3
BIN_ZIPADJUST=$MYFOLDER/zipadjust

FILE_MATCH=omni-*.zip
PATH_CURRENT=$HOME/out/target/product/$DEVICE
PATH_LAST=$HOME/../releases/ota/publish/$DEVICE

KEY_X509=$HOME/${ROM_KEYS_PATH}/platform.x509.pem
KEY_PK8=$HOME/${ROM_KEYS_PATH}/platform.pk8

# ------ PROCESS ------

getFileName() {
	echo ${1##*/}
}

getFileNameNoExt() {
	echo ${1%.*}
}

getFileMD5() {
	TEMP=$(md5sum -b $1)
	for T in $TEMP; do echo $T; break; done
}

getFileSize() {
	echo $(stat --print "%s" $1)
}

nextPowerOf2() {
    local v=$1;
    ((v -= 1));
    ((v |= $v >> 1));
    ((v |= $v >> 2));
    ((v |= $v >> 4));
    ((v |= $v >> 8));
    ((v |= $v >> 16));
    ((v += 1));
    echo $v;
}

FILE_CURRENT=$(getFileName $(ls -1 $PATH_CURRENT/$FILE_MATCH))
FILE_LAST=$(getFileName $(ls -1 $PATH_LAST/$FILE_MATCH))
FILE_LAST_BASE=$(getFileNameNoExt $FILE_LAST)

if [ "$FILE_CURRENT" == "" ]; then
	echo -e ${RED}"Abort: CURRENT zip not found"${NC} >&2
	exit 1
fi

if [ "$FILE_LAST" == "" ]; then
	echo -e ${RED}"Abort: LAST zip not found"${NC} >&2
	mkdir -p $PATH_LAST
	cp -v $PATH_CURRENT/$FILE_CURRENT $PATH_LAST/$FILE_CURRENT
	exit 0
fi

if [ "$FILE_LAST" == "$FILE_CURRENT" ]; then
	echo -e ${RED}"Abort: CURRENT ($FILE_CURRENT) and LAST ($FILE_LAST) zip have the same name"${NC} >&2
	exit 1
fi

rm -rf $HOME/../releases/ota/work
mkdir -p $HOME/../releases/ota/work
rm -rf $HOME/../releases/ota/out
mkdir -p $HOME/../releases/ota/out

$BIN_ZIPADJUST --decompress $PATH_CURRENT/$FILE_CURRENT $HOME/../releases/ota/work/current.zip
$BIN_ZIPADJUST --decompress $PATH_LAST/$FILE_LAST $HOME/../releases/ota/work/last.zip
$BIN_JAVA -Xmx4096m -jar $BIN_MINSIGNAPK $KEY_X509 $KEY_PK8 $HOME/../releases/ota/work/current.zip $HOME/../releases/ota/work/current_signed.zip
if [ $? -ne 0 ]; then
	echo -e ${RED}"Abort: creating signing info for current failed"${NC} >&2
	exit 1
fi
$BIN_JAVA -Xmx4096m -jar $BIN_MINSIGNAPK $KEY_X509 $KEY_PK8 $HOME/../releases/ota/work/last.zip $HOME/../releases/ota/work/last_signed.zip
if [ $? -ne 0 ]; then
	echo -e ${RED}"Abort: creating signing info for last failed"${NC} >&2
	exit 1
fi
SRC_BUFF=$(nextPowerOf2 $(getFileSize $HOME/../releases/ota/work/current.zip));
$BIN_XDELTA -B ${SRC_BUFF} -9evfS none -s $HOME/../releases/ota/work/last.zip $HOME/../releases/ota/work/current.zip $HOME/../releases/ota/out/$FILE_LAST_BASE.update
SRC_BUFF=$(nextPowerOf2 $(getFileSize $HOME/../releases/ota/work/current_signed.zip));
$BIN_XDELTA -B ${SRC_BUFF} -9evfS none -s $HOME/../releases/ota/work/current.zip $HOME/../releases/ota/work/current_signed.zip $HOME/../releases/ota/out/$FILE_LAST_BASE.sign

MD5_CURRENT=$(getFileMD5 $PATH_CURRENT/$FILE_CURRENT)
MD5_CURRENT_STORE=$(getFileMD5 $HOME/../releases/ota/work/current.zip)
MD5_CURRENT_STORE_SIGNED=$(getFileMD5 $HOME/../releases/ota/work/current_signed.zip)
MD5_LAST=$(getFileMD5 $PATH_LAST/$FILE_LAST)
MD5_LAST_STORE=$(getFileMD5 $HOME/../releases/ota/work/last.zip)
MD5_LAST_STORE_SIGNED=$(getFileMD5 $HOME/../releases/ota/work/last_signed.zip)
MD5_UPDATE=$(getFileMD5 $HOME/../releases/ota/out/$FILE_LAST_BASE.update)
MD5_SIGN=$(getFileMD5 $HOME/../releases/ota/out/$FILE_LAST_BASE.sign)

SIZE_CURRENT=$(getFileSize $PATH_CURRENT/$FILE_CURRENT)
SIZE_CURRENT_STORE=$(getFileSize $HOME/../releases/ota/work/current.zip)
SIZE_CURRENT_STORE_SIGNED=$(getFileSize $HOME/../releases/ota/work/current_signed.zip)
SIZE_LAST=$(getFileSize $PATH_LAST/$FILE_LAST)
SIZE_LAST_STORE=$(getFileSize $HOME/../releases/ota/work/last.zip)
SIZE_LAST_STORE_SIGNED=$(getFileSize $HOME/../releases/ota/work/last_signed.zip)
SIZE_UPDATE=$(getFileSize $HOME/../releases/ota/out/$FILE_LAST_BASE.update)
SIZE_SIGN=$(getFileSize $HOME/../releases/ota/out/$FILE_LAST_BASE.sign)

DELTA=~/../releases/ota/out/$FILE_LAST_BASE.delta

echo "{" > $DELTA
echo "  \"version\": 1," >> $DELTA
echo "  \"in\": {" >> $DELTA
echo "      \"name\": \"$FILE_LAST\"," >> $DELTA
echo "      \"size_store\": $SIZE_LAST_STORE," >> $DELTA
echo "      \"size_store_signed\": $SIZE_LAST_STORE_SIGNED," >> $DELTA
echo "      \"size_official\": $SIZE_LAST," >> $DELTA
echo "      \"md5_store\": \"$MD5_LAST_STORE\"," >> $DELTA
echo "      \"md5_store_signed\": \"$MD5_LAST_STORE_SIGNED\"," >> $DELTA
echo "      \"md5_official\": \"$MD5_LAST\"" >> $DELTA
echo "  }," >> $DELTA
echo "  \"update\": {" >> $DELTA
echo "      \"name\": \"$FILE_LAST_BASE.update\"," >> $DELTA
echo "      \"size\": $SIZE_UPDATE," >> $DELTA
echo "      \"size_applied\": $SIZE_CURRENT_STORE," >> $DELTA
echo "      \"md5\": \"$MD5_UPDATE\"," >> $DELTA
echo "      \"md5_applied\": \"$MD5_CURRENT_STORE\"" >> $DELTA
echo "  }," >> $DELTA
echo "  \"signature\": {" >> $DELTA
echo "      \"name\": \"$FILE_LAST_BASE.sign\"," >> $DELTA
echo "      \"size\": $SIZE_SIGN," >> $DELTA
echo "      \"size_applied\": $SIZE_CURRENT_STORE_SIGNED," >> $DELTA
echo "      \"md5\": \"$MD5_SIGN\"," >> $DELTA
echo "      \"md5_applied\": \"$MD5_CURRENT_STORE_SIGNED\"" >> $DELTA
echo "  }," >> $DELTA
echo "  \"out\": {" >> $DELTA
echo "      \"name\": \"$FILE_CURRENT\"," >> $DELTA
echo "      \"size_store\": $SIZE_CURRENT_STORE," >> $DELTA
echo "      \"size_store_signed\": $SIZE_CURRENT_STORE_SIGNED," >> $DELTA
echo "      \"size_official\": $SIZE_CURRENT," >> $DELTA
echo "      \"md5_store\": \"$MD5_CURRENT_STORE\"," >> $DELTA
echo "      \"md5_store_signed\": \"$MD5_CURRENT_STORE_SIGNED\"," >> $DELTA
echo "      \"md5_official\": \"$MD5_CURRENT\"" >> $DELTA
echo "  }" >> $DELTA
echo "}" >> $DELTA

mkdir -p $HOME/../releases/ota/publish/$DEVICE
cp $HOME/../releases/ota/out/* $HOME/../releases/ota/publish/$DEVICE/.

rm -rf $HOME/../releases/work
rm -rf $HOME/../releases/out

#rm -rf $PATH_LAST/*
mkdir -p $PATH_LAST
cp $PATH_CURRENT/$FILE_CURRENT $PATH_LAST/$FILE_CURRENT


exit 0
