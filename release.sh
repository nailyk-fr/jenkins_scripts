#!/bin/bash


if [ ! -d "$HOME/../releases/cm-14.1" ]; then 
	mkdir -p $HOME/../releases/cm-14.1
fi

if [ -d "$HOME/../releases/cm-14.1" ]; then 
	echo copy lineage
	find $HOME/out/target/product -maxdepth 2 -mindepth 2 -iname "lineage-*.zip*" -print -exec cp --no-clobber {} $HOME/../releases/cm-14.1 \;
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
			eval cp -v --no-clobber $folder/recovery.img $HOME/../releases/twrp/$filename.img
		fi
		if [ -e "$folder/recovery-updater-signed.zip" ]; then
			eval cp -v --no-clobber $folder/recovery-updater-signed.zip $HOME/../releases/twrp/$filename.zip
		fi
	done
else
	false
fi

