#! /bin/bash

run(){
	cat >&3 <<EOM
/home/alberto/src/elk-4.3.6/src/elk 2>&1 > elk.out ${AMP}

EOM
}
