#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.MINP MINP
dmrcc 2>&1 > ${i}.out ${AMP}

EOM
}
