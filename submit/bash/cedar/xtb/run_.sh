#! /bin/bash

run_(){
	cat >&3 <<EOM
/home/alberto/git/xtb/_install/bin/xtb \${INITOPTS} ${i}.gen > ${i}.out ${AMP}

EOM
}
