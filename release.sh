#!/bin/bash


echo publish for $1

if [ ! -d "$HOME/../releases/cm-13.0" ]; then 
	mkdir $HOME/../releases/cm-13.0
fi

if [ -d "$HOME/../releases/cm-13.0" ]; then 
	cp -n $HOME/out/target/product/$1/lineage-*.zip* $HOME/../releases/cm-13.0
else
	false
fi
