#! /bin/bash

run(){
	cat >&3 <<EOM
cd $(pwd)/
g16 ${i}.gjf ${AMP}

EOM
}
