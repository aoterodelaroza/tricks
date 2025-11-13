#! /bin/bash

list_(){
    if [ "$runlist" == "pack" ] ; then
	list=$(find . -maxdepth 1 -type f -name '*.tar.xz' -printf '%P\n' | shuf)
	extension=".tar.xz"
    else
	list=$(find . -maxdepth 1 -type f -name '*.gjf' -printf '%P\n' | shuf)
	extension=".gjf"
    fi
    prefix="gau"
}
