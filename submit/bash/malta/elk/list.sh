#! /bin/bash

list(){
    local alist=$(find . -maxdepth 1 -type d -printf '%P\n' | grep -v '^ *$' | shuf)
    list=""
    for i in $alist ; do
	if [ -f ${i}/elk.in ]; then
	   list+=" ${i}"
	fi
    done
    extension="/"
    prefix="cry"
}
