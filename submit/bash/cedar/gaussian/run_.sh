#! /bin/bash

run_(){
	cat >&3 <<EOM
g16 ${i}.gjf ${AMP}

EOM
}
