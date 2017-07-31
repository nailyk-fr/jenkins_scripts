#!/bin/bash

echo cleanup of releases started

if [ -d "$HOME/../releases/omni" ]; then
	find $HOME/../releases/omni -depth -xdev -type f -mtime +15 -delete -print
	echo Releases deleted
fi

if [ -d "$HOME/out/target/product" ]; then
	rm -rfv $HOME/out/target/product
fi
