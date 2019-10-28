#! /bin/bash

run_(){
	cat >&3 <<EOM
/opt/uovi/alberto/elk-6.3.2/src/elk 2>&1 > elk.out ${AMP}

EOM
}
