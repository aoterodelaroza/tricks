#! /bin/bash

run_(){
	cat >&3 <<EOM
/opt/software/dftbplus-24.1/bin/dftb+ > ${i}.out ${AMP}

EOM
}
