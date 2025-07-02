#! /bin/bash

clean_(){
    cat >&3 <<EOM
rm -f diis* INPUT fort.*

EOM
}
