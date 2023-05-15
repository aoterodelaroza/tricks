#! /bin/bash

run_(){
	cat >&3 <<EOM
cp ${i}.inp ${i}.xyz \${TMPDIR}
cd \${TMPDIR}
\$(which orca) ${i}.inp 2>&1 > $(pwd)/${i}.out ${AMP}

EOM
}
