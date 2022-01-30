#! /bin/bash

run_(){
	cat >&3 <<EOM

python3 ${i}.py > ${i}.out

EOM
}
