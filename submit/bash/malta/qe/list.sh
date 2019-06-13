#! /bin/bash

list(){
    local alist=$(find . -maxdepth 1 -type d -printf '%P\n' | grep -v '^ *$' | shuf)
    list=""
    for i in $alist ; do
	if [ -f ${i}/${i}.scf.in ]; then
	   list+=" ${i}"
	fi
    done
    extension="/"
    prefix="qe"
}
