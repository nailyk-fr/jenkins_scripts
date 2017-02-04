#!/bin/bash

# bin/mm-qcamera-daemon

lib_lookup() {

	readelf -d $1 | grep NEEDED | cut -d "[" -f2 | cut -d"]" -f 1
	#readelf -d $1 | awk '/NEEDED/ {print $5}' | sed -e 's/\[\|\]//g'

}

so_search() {
	for file in `lib_lookup $1`; do
		find . -iname "$file" 2>/dev/null
	done
}

global_search() {
	RESULT=$(so_search $1 | egrep -v "^${FOUND}" | grep -v "libc.so\|libdl.so\|libc++.so\|libm.so\|liblog.so\|libcutils.so")
	for blob in `echo -n $RESULT`; do
		echo $blob
		FOUND=$1\|$FOUND
		global_search $blob
	done

}

FOUND=$1
global_search $1

