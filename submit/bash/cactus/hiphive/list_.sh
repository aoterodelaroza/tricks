#! /bin/bash

list_(){
    local alist=$(find . -maxdepth 1 -type d -printf '%P\n' | grep -v '^ *$' | shuf)
    list=""
    for i in $alist ; do
	if [ -f ${i}/0-write_structure_info.py ]; then
	   list+=" ${i}"
	fi
    done
    extension="/"
    prefix="hph"
}
