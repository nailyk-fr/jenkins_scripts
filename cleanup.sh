#!/bin/bash

echo cleanup of releases started

if [ -d "$HOME/../releases/copperhead" ]; then
	find $HOME/../releases/copperhead -depth -xdev -type f -mtime +30 -delete -print
	echo Releases deleted
fi

if [ -d "$HOME/out/target/product" ]; then
	rm -rfv $HOME/out/target/product
fi
