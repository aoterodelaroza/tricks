!#! /bin/bash

run_(){
	cat >&3 <<EOM
runmpi17 ${ncpu} ${i} ${AMP}

EOM
}
