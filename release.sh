#!/bin/bash


echo publish for $1

if [ ! -d "$HOME/../releases/cm-14.1" ]; then 
	mkdir $HOME/../releases/cm-14.1
fi

if [ -d "$HOME/../releases/cm-14.1" ]; then 
	find $HOME/out/target/product -maxdepth 2 -mindepth 2 -iname "lineage-*.zip" -exec cp {} $HOME/../releases/cm-14.1 \;
else
	false
fi
