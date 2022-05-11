#! /bin/bash

run_(){
	cat >&3 <<EOM
\$(which orca) ${i}.inp 2>&1 > ${i}.out ${AMP}
# orca_2aim ${i}
# xz ${i}.gbw

EOM
}
