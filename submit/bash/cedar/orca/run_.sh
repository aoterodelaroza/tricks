#! /bin/bash

run_(){
	cat >&3 <<EOM
\$(which orca) ${i}.inp 2>&1 > ${i}.out ${AMP}
# xz ${i}.gbw

EOM
}
