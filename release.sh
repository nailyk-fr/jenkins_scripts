#!/bin/bash


if [ ! -d "$HOME/../releases/lineage" ]; then 
	mkdir -p $HOME/../releases/lineage
fi

if [ -d "$HOME/../releases/lineage" ]; then 
	echo copy lineage
	find $HOME/out/target/product -maxdepth 2 -mindepth 2 -iname "lineage-*.zip*" -exec cp --verbose --update {} $HOME/../releases/lineage \;
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
			md5=$(md5sum ${folder}/recovery.img | awk '{print $1}' )
			echo "addDescription \"md5: ${md5}\" ${filename}" >> $HOME/../releases/twrp/.htaccess
		fi
		if [ -e "$folder/recovery-updater-signed.zip" ]; then
			eval cp --verbose --update $folder/recovery-updater-signed.zip $HOME/../releases/twrp/$filename.zip
		fi
	done
else
	false
fi

