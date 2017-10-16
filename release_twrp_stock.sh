#!/bin/bash


if [ ! -d "$HOME/../releases/twrp" ]; then
	mkdir -p $HOME/../releases/twrp
fi

if [ -d "$HOME/../releases/twrp" ]; then
		echo copy twrp
		filename="twrp_${CODENAME}_STOCK_$(date +"%Y-%m-%d")"
		echo "eval: $HOME/out/target/product/${CODENAME}/recovery.img"
		if [ -e "$HOME/out/target/product/${CODENAME}/recovery.img" ]; then
			eval cp --verbose --update $HOME/out/target/product/${CODENAME}/recovery.img $HOME/../releases/twrp/$filename.img
			echo "addDescription \"md5: $(md5sum $HOME/../releases/twrp/$filename.img | awk '{ print $1 }')\" $filename.img" >> $HOME/../releases/twrp/.htaccess
		fi
		if [ -e "$HOME/out/target/product/${CODENAME}/recovery-updater-signed.zip" ]; then
			eval cp --verbose --update $HOME/out/target/product/${CODENAME}/recovery-updater-signed.zip $HOME/../releases/twrp/$filename.zip
			echo "addDescription \"md5: $(md5sum $HOME/../releases/twrp/$filename.zip | awk '{ print $1 }')\" $filename.zip" >> $HOME/../releases/twrp/.htaccess
			echo copy zip
		fi
else
	false
fi

