#!/bin/bash


if [ ! -d "$HOME/../releases/omni" ]; then 
	mkdir -p $HOME/../releases/omni
fi

if [ -d "$HOME/../releases/omni" ]; then 
	echo copy omni
	find $HOME/out/target/product -maxdepth 2 -mindepth 2 -iname "omni-*.zip*" -exec cp --verbose --update {} $HOME/../releases/omni \;
else
	false
fi

if [ ! -d "$HOME/../releases/twrp" ]; then
	mkdir -p $HOME/../releases/twrp
fi

if [ -d "$HOME/../releases/twrp" ]; then
	for folder in `find $HOME/out/target/product -maxdepth 1 -type d`; do
		echo copy twrp
		filename="twrp_$(basename $folder)_$(date +"%Y-%m-%d")"
		if [ -e "$folder/recovery.img" ]; then
			eval cp --verbose --update $folder/recovery.img $HOME/../releases/twrp/$filename.img
			echo "addDescription \"md5: $(md5sum $HOME/../releases/twrp/$filename.img | awk '{ print $1 }')\" $filename.img" >> $HOME/../releases/twrp/.htaccess
		fi
		if [ -e "$folder/recovery-updater-signed.zip" ]; then
			eval cp --verbose --update $folder/recovery-updater-signed.zip $HOME/../releases/twrp/$filename.zip
			echo "addDescription \"md5: $(md5sum $HOME/../releases/twrp/$filename.zip | awk '{ print $1 }')\" $filename.zip" >> $HOME/../releases/twrp/.htaccess
		fi
	done
else
	false
fi

