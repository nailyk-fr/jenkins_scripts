#!/bin/bash

echo cleanup of releases started

if [ -d "$HOME/../releases/omni" ]; then
	find $HOME/../releases/omni -depth -xdev -type f -mtime +40 -delete -print
	echo Releases deleted
fi

if [ -d "$HOME/../releases/twrp" ]; then
	for file in $(find $HOME/../releases/twrp -depth -xdev -type f -mtime +20 -print)
	do
		if [ -f $HOME/../releases/twrp/.htaccess ] ; then
			short_name=$(basename ${file})
			sed -i '/${short_name}/d' $HOME/../releases/twrp/.htaccess
		fi
		rm -fv ${file}
	done
	echo TWRP releases deleted
fi

if [ -d "$HOME/out/soong" ]; then
	rm -rfv $HOME/out/soong
fi

if [ -d "$HOME/out/target/product" ]; then
	rm -rfv $HOME/out/target/product
fi
