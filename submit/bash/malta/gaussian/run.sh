#! /bin/bash

run(){
	cat >&3 <<EOM
cd $(pwd)/
g09 ${i}.gjf ${AMP}

EOM
}
