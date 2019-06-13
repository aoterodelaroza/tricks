#! /bin/bash

run_(){
	cat >&3 <<EOM
runmpi17 12 ${i} ${AMP}

EOM
}
