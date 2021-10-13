#! /bin/bash

run_(){
	cat >&3 <<EOM
dmrcc 2>&1 > ${i}.out ${AMP}

EOM
}
