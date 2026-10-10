#! /bin/bash

run_(){
    cat >&3 <<EOM
\$CRITIC2 ${i}.cri ${i}.cro ${AMP}

EOM
}
