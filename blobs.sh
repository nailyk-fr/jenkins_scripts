#!/bin/bash

# bin/mm-qcamera-daemon

lib_lookup() {

	readelf -d $1 | grep NEEDED | cut -d "[" -f2 | cut -d"]" -f 1

}

so_search() {
	for file in `lib_lookup $1`; do
		find . -iname "$file" 2>/dev/null
	done
}

global_search() {
	for blob in `so_search $1`; do 
		so_search $blob 
	done
}


global_search $1 | sort | uniq
