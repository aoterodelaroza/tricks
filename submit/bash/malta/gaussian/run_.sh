#! /bin/bash

run_(){
	cat >&3 <<EOM
\${GAUPROGRAM} ${i}.gjf ${AMP}

EOM
}
