#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f diis* fort.* INPUT SCFOUT.LOG
EOM
}
