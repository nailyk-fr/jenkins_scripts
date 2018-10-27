#!/bin/bash

echo cleanup of releases started

if [ -d "$HOME/../releases/omni" ]; then
	find $HOME/../releases/omni -depth -xdev -type f -mtime +40 -delete -print
	echo Releases deleted
fi

if [ -d "$HOME/../releases/twrp" ]; then
    find $HOME/../releases/twrp -depth -xdev -type f -mtime +20 -delete -print
    echo TWRP releases deleted
fi

if [ -d "$HOME/out/soong" ]; then
	rm -rfv $HOME/out/soong
fi

if [ -d "$HOME/out/target/product" ]; then
	rm -rfv $HOME/out/target/product
fi
