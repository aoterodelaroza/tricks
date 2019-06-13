#! /bin/bash

clean(){
    cat >&3 <<EOM
rm -f diis* fort.* INPUT

EOM
}
