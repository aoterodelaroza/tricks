#! /bin/bash

run_(){
	cat >&3 <<EOM
dftb+ > ${i}.out ${AMP}

EOM
}
