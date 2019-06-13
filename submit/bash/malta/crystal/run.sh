#! /bin/bash

run(){
	cat >&3 <<EOM
runmpi17 12 ${i}

EOM
}
