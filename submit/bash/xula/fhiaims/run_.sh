#! /bin/bash

run_(){
	cat >&3 <<EOM

srun \$FHIBIN < /dev/null > ${i}.out

EOM
}
