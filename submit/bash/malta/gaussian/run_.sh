#! /bin/bash

run_(){
	cat >&3 <<EOM
g09 ${i}.gjf ${AMP}

EOM
}
