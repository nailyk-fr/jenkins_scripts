#!/bin/bash

if [ ! -d "$HOME/../releases/kernel" ]; then
	mkdir -p $HOME/../releases/kernel
fi

if [ -d "$HOME/../releases/kernel" ]; then
  for folder in `find $HOME/out/target/product -maxdepth 1 -type d`; do
    echo copy kernel
    filename="boot_$(basename $folder)_$(date +"%Y-%m-%d")"
    if [ -e "$folder/boot.img" ]; then
      eval cp --verbose --update $folder/boot.img $HOME/../releases/kernel/$filename.img
	  echo "addDescription \"md5: $(md5sum $HOME/../releases/kernel/$filename.img | awk '{ print $1 }')\" $filename.img" >> $HOME/../releases/kernel/.htaccess
    fi  
  done
else
  false
fi

