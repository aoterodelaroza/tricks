#! /bin/bash

run_(){
	cat >&3 <<EOM
/home/alberto/src/dftbplus-20.2.1/_install/bin/dftb+ > ${i}.out ${AMP}

EOM
}
