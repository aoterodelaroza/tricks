#! /bin/bash

run_(){
	cat >&3 <<EOM

mpirun \$FHIBIN < /dev/null > ${i}.out

EOM
}
