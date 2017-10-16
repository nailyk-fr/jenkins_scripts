#!/bin/bash


if [ ! -d "$HOME/../releases/twrp" ]; then
	mkdir -p $HOME/../releases/twrp
fi

if [ -d "$HOME/../releases/twrp" ]; then
	for folder in `find $HOME/out/target/product -maxdepth 1 -type d`; do
		echo copy twrp
		filename="twrp_$(basename $folder)_STOCK_$(date +"%Y-%m-%d")"
		if [ -e "$folder/recovery.img" ]; then
			eval cp --verbose --update $folder/recovery.img $HOME/../releases/twrp/$filename.img
		fi
		if [ -e "$folder/recovery-updater-signed.zip" ]; then
			eval cp --verbose --update $folder/recovery-updater-signed.zip $HOME/../releases/twrp/$filename.zip
		fi
	done
else
	false
fi

