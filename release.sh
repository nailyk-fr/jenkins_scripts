#!/bin/bash


echo publish for $1

if [ ! -d "$HOME/../releases/cm-12.1" ]; then 
	mkdir $HOME/../releases/cm-12.1
fi

if [ -d "$HOME/../releases/cm-12.1" ]; then 
	cp $HOME/out/target/product/$1/cm-*.zip* $HOME/../releases/cm-12.1
else
	false
fi
