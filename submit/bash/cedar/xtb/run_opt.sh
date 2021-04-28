#! /bin/bash

run_opt(){
	cat >&3 <<EOM
/home/alberto/git/xtb/_install/bin/xtb \${INITOPTS} -o tight ${i}.gen > ${i}.out ${AMP}

EOM
}
