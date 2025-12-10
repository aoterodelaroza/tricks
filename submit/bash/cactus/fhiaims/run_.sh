#! /bin/bash

run_(){
	cat >&3 <<EOM
mpirun \$FHIAIMS < /dev/null > ${i}.out

EOM
}
