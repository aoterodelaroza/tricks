#! /bin/bash

clean_(){
    cat >&3 <<EOM
# rm -f diis* fort.* INPUT optc* *.LOG *.DAT *.dat

EOM
}
