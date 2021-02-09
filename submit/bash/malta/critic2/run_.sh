#! /bin/bash

run_(){
	cat >&3 <<EOM
/opt/uovi/alberto/critic2/bin/critic2 ${i}.cri ${i}.cro ${AMP}

EOM
}
