#!/bin/bash

MYFOLDER="$(dirname "$(realpath "$0")")"
source $MYFOLDER/colors.sh

if [ ! -d "$HOME/../releases/cm-14.1" ]; then 
	mkdir -p $HOME/../releases/cm-14.1
fi

if [ -d "$HOME/../releases/cm-14.1" ]; then 
	echo -e ${BLUE}"copy lineage"${NC}
	find $HOME/out/target/product -maxdepth 2 -mindepth 2 -iname "lineage-*.zip*" \
    -exec echo -e ${GREEN}"copying {}"${NC} \; \
    -exec cp --verbose --update {} $HOME/../releases/cm-14.1 \;
else
	false
fi

if [ ! -d "$HOME/../releases/twrp" ]; then
	mkdir -p $HOME/../releases/twrp
fi

if [ -d "$HOME/../releases/twrp" ]; then
	for folder in `find $HOME/out/target/product -maxdepth 1 -type d`; do
		echo -e ${BLUE}"copy twrp from $folder"${NC}
		filename="twrp_$(basename $folder)_$(date +"%Y-%m-%d")"
		if [ -e "$folder/recovery.img" ]; then
			echo -e ${GREEN}"    Copying $filename.img"${NC}
			eval cp --verbose --update $folder/recovery.img $HOME/../releases/twrp/$filename.img
			echo "addDescription \"md5: $(md5sum $HOME/../releases/twrp/$filename.img | awk '{ print $1 }')\" $filename.img" >> $HOME/../releases/twrp/.htaccess
		fi
		if [ -e "$folder/recovery-updater-signed.zip" ]; then
			echo -e ${GREEN}"    Copying $filename.img"${NC}
			eval cp --verbose --update $folder/recovery-updater-signed.zip $HOME/../releases/twrp/$filename.zip
			echo "addDescription \"md5: $(md5sum $HOME/../releases/twrp/$filename.img | awk '{ print $1 }')\" $filename.img" >> $HOME/../releases/twrp/.htaccess
		fi
	done
else
	false
fi

